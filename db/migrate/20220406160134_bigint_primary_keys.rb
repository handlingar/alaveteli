class BigintPrimaryKeys < ActiveRecord::Migration[6.1]
  def up
    change_column :acts_as_xapian_jobs, :id, :bigint
    change_column :announcement_dismissals, :id, :bigint
    change_column :announcement_translations, :id, :bigint
    change_column :announcements, :id, :bigint
    change_column :censor_rules, :id, :bigint
    change_column :comments, :id, :bigint
    change_column :draft_info_request_batches, :id, :bigint
    change_column :draft_info_requests, :id, :bigint
    change_column :embargo_extensions, :id, :bigint
    change_column :embargoes, :id, :bigint
    change_column :flipper_features, :id, :bigint
    change_column :flipper_gates, :id, :bigint
    change_column :foi_attachments, :id, :bigint
    change_column :has_tag_string_tags, :id, :bigint
    change_column :holidays, :id, :bigint
    change_column :incoming_message_errors, :id, :bigint
    change_column :info_request_batches, :id, :bigint
    change_column :mail_server_log_dones, :id, :bigint
    change_column :notifications, :id, :bigint
    change_column :outgoing_messages, :id, :bigint
    change_column :post_redirects, :id, :bigint
    change_column :pro_accounts, :id, :bigint
    change_column :profile_photos, :id, :bigint
    change_column :public_bodies, :id, :bigint
    change_column :public_body_categories, :id, :bigint
    change_column :public_body_category_links, :id, :bigint
    change_column :public_body_change_requests, :id, :bigint
    change_column :public_body_headings, :id, :bigint
    change_column :request_classifications, :id, :bigint
    change_column :request_summaries, :id, :bigint
    change_column :request_summary_categories, :id, :bigint
    change_column :roles, :id, :bigint
    change_column :spam_addresses, :id, :bigint
    change_column :track_things, :id, :bigint
    change_column :track_things_sent_emails, :id, :bigint
    change_column :user_info_request_sent_alerts, :id, :bigint
    change_column :users, :id, :bigint
    change_column :webhooks, :id, :bigint
    change_column :widget_votes, :id, :bigint
  end

  def down
    change_column :widget_votes, :id, :integer
    change_column :webhooks, :id, :integer
    change_column :user_info_request_sent_alerts, :id, :integer
    change_column :users, :id, :integer
    change_column :track_things_sent_emails, :id, :integer
    change_column :track_things, :id, :integer
    change_column :spam_addresses, :id, :integer
    change_column :roles, :id, :integer
    change_column :request_summary_categories, :id, :integer
    change_column :request_summaries, :id, :integer
    change_column :request_classifications, :id, :integer
    change_column :public_body_headings, :id, :integer
    change_column :public_body_change_requests, :id, :integer
    change_column :public_body_category_links, :id, :integer
    change_column :public_body_categories, :id, :integer
    change_column :public_bodies, :id, :integer
    change_column :pro_accounts, :id, :integer
    change_column :profile_photos, :id, :integer
    change_column :post_redirects, :id, :integer
    change_column :outgoing_messages, :id, :integer
    change_column :notifications, :id, :integer
    change_column :mail_server_log_dones, :id, :integer
    change_column :info_request_batches, :id, :integer
    change_column :incoming_message_errors, :id, :integer
    change_column :holidays, :id, :integer
    change_column :has_tag_string_tags, :id, :integer
    change_column :foi_attachments, :id, :integer
    change_column :flipper_gates, :id, :integer
    change_column :flipper_features, :id, :integer
    change_column :embargo_extensions, :id, :integer
    change_column :embargoes, :id, :integer
    change_column :draft_info_request_batches, :id, :integer
    change_column :draft_info_requests, :id, :integer
    change_column :comments, :id, :integer
    change_column :censor_rules, :id, :integer
    change_column :announcement_translations, :id, :integer
    change_column :announcement_dismissals, :id, :integer
    change_column :announcements, :id, :integer
    change_column :acts_as_xapian_jobs, :id, :integer
  end
end
