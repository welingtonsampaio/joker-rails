module Joker::Rails
  module Concerns

    module Upload

      STORAGE_LOCALPATH = :localpath
      STORAGE_S3 = :s3
      STORAGE_GCS = :gcs

      attr_accessor :storage,
                    :bucket,
                    :multiple,
                    :s3_permission,
                    :url,
                    :params,
                    :google_storage_access_key_id,
                    :google_storage_secret_access_key,
                    :google_storage_permission,
                    :data

      def base_path
        throw "Voce precisa informa a pasta base para o envio"
      end

      def path
        throw "Voce precisa informar qual a pasta"
      end

      def region
        throw "Voce presisa informar qual a regiao do S3"
      end


      def setup(&block)
        self.storage = STORAGE_LOCALPATH
        self.multiple = true
        self.s3_permission = :private

        yield self if block_given?
        self
      end

      def save params
        @params = params
        case storage
          when STORAGE_LOCALPATH
            save_localpath params
          when STORAGE_S3
            save_s3 params
          when STORAGE_GCS
            save_gcs params
          else
            throw "Armazenamento nao especificado"
        end
      end

      def save_success
        {status: :OK}.to_json
      end

      private
      def save_localpath params

      end

      def save_s3 params
        raise "Voce precisa adicionar a gem 'aws-s3'" unless AWS
        AWS::S3::DEFAULT_HOST.replace "s3-#{region}.amazonaws.com"

        AWS::S3::S3Object.store get_save_name,
                                params[:file],
                                bucket,
                                :access => s3_permission
        save_success
      end

      def save_gcs params
        raise "Voce precisa adicionar a gem 'fog'" unless Fog

        @conn = Fog::Storage::Google.new google_storage_access_key_id: google_storage_access_key_id,
                                         google_storage_secret_access_key: google_storage_secret_access_key
        @conn.put_object bucket,
                         get_save_name,
                         params[:file],
                         'x-goog-acl' => google_storage_permission || 'public'

        save_success
      end

      def generate_filename name
        r = /(.+)-(\w+)$/
        name.parameterize.gsub(r) { "#{$1}.#{$2}" }
      end

      def get_save_name
        base_path + '/' + path + '/' + generate_filename(params[:name])
      end

    end
  end
end
