RSpec.shared_context 'disable not_many_requests tagging', not_many_requests_tag: false do
  around do |example|
    orig = PublicBody.not_many_public_requests_size
    PublicBody.not_many_public_requests_size = 0
    example.run
    PublicBody.not_many_public_requests_size = orig
  end
end
