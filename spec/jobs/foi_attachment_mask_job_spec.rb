require 'spec_helper'

RSpec.describe FoiAttachmentMaskJob, type: :job do
  let(:info_request) { FactoryBot.create(:info_request_with_html_attachment) }
  let(:incoming_message) { info_request.incoming_messages.first }
  let(:attachment) { incoming_message.foi_attachments.last }

  def perform
    described_class.new.perform(attachment)
  end

  before { rebuild_raw_emails(info_request) }

  it 'update the attachment body' do
    info_request.censor_rules.create!(
      text: 'dull', replacement: 'boring',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )

    expect(attachment.body).to include('dull')
    expect(attachment.body).to_not include('boring')
    expect { perform }.to change { attachment.body }
    expect(attachment.body).to_not include('dull')
    expect(attachment.body).to include('boring')
  end

  it 'update the attachment masked_at' do
    info_request.censor_rules.create!(
      text: 'dull', replacement: 'boring',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )

    expect { perform }.to change { attachment.masked_at }.to(Time)
  end

  it 'sanitises HTML attachments' do
    # Nokogiri adds the meta tag; see
    # https://github.com/sparklemotion/nokogiri/issues/1008
    expected = <<-EOF.squish
    <!DOCTYPE html>
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      </head>
      <body>dull
      </body>
    </html>
    EOF

    perform
    expect(attachment.body.squish).to eq(expected)
  end

  it 'censors attachments downloaded directly' do
    info_request.censor_rules.create!(
      text: 'dull', replacement: 'Boy',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )
    perform
    expect(attachment.body).to_not include 'dull'
    expect(attachment.body).to include 'Boy'
  end

  it 'censors with rules on the user (rather than the request)' do
    info_request.user.censor_rules.create!(
      text: 'dull', replacement: 'Mole',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )
    perform
    expect(attachment.body).to_not include 'dull'
    expect(attachment.body).to include 'Mole'
  end

  it 'censors with rules on the public body (rather than the request)' do
    info_request.public_body.censor_rules.create!(
      text: 'dull', replacement: 'Fox',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )
    perform
    expect(attachment.body).to_not include 'dull'
    expect(attachment.body).to include 'Fox'
  end

  it 'censors with rules globally (rather than the request)' do
    CensorRule.create!(
      text: 'dull', replacement: 'Horse',
      last_edit_editor: 'unknown', last_edit_comment: 'none'
    )
    perform
    expect(attachment.body).to_not include 'dull'
    expect(attachment.body).to include 'Horse'
  end

  context 'after rescuing from FoiAttachment::MissingAttachment' do
    before do
      # first call to #unmasked_body should raise MissingAttachment exception
      # subsequent calls should call the original method.
      @raised = false
      allow(attachment).to receive(:unmasked_body).
        and_wrap_original do |original_method, *args, &block|
          unless @raised
            @raised = true
            raise FoiAttachment::MissingAttachment
          end
          original_method.call(*args, &block)
        end
    end

    it 'parses raw email again' do
      expect(incoming_message).to receive(:parse_raw_email!).with(true)
      perform
    end

    it 'masks the body' do
      CensorRule.create!(
        text: 'dull', replacement: 'Orange',
        last_edit_editor: 'unknown', last_edit_comment: 'none'
      )
      perform
      expect(attachment.body).to include 'Orange'
    end

    it 'rebuilds the attachment and masks if the hexdigest does not match' do
      CensorRule.create!(
        text: 'dull', replacement: 'Banana',
        last_edit_editor: 'unknown', last_edit_comment: 'none'
      )

      attachment.update(hexdigest: '123')
      perform

      new_attachment = IncomingMessage.
        get_attachment_by_url_part_number_and_filename!(
          incoming_message.get_attachments_for_display,
          attachment.url_part_number,
          attachment.display_filename
        )
      expect(new_attachment.unmasked_body).to include 'dull'
      expect(new_attachment.body).to include 'Banana'
    end
  end
end
