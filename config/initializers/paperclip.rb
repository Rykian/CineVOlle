# Isolate var and functions definitions
begin

  # Set option only if it's in ENV variables
  # @param [Hash] path Object in which options should be merged
  # @param [Hash] hash Object to merge (keys are options in Ruby, values are ENV
  #   variables or sub-level hash)
  def set_paperclip_options(path, hash)
    path = Paperclip::Attachment.default_options if path.nil?
    hash.each do |key, value|
      if value.instance_of? String
        path[key] = value unless ENV[value].nil?
      else
        set_paperclip_options(path[:key], value)
      end
    end
  end

  set_paperclip_options nil, storage: 'PAPERCLIP_STORAGE',
                             bucket: 'PAPERCLIP_BUCKET',
                             s3_credentials: {
                               access_key_id: 'S3_ACCESS_KEY_ID',
                               secret_access_key: 'S3_SECRET_ACCESS_KEY' }
end
