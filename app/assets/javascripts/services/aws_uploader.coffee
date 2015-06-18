@Sim.service "AwsUploader", ['$http', 'Upload',
  ($http, Upload) ->
    AWS_PROPERTIES_PATH = "/api/aws_properties"
    URL = "https://#{window.Config.aws.bucket_name}.s3.amazonaws.com/"

    contentType: (file) ->
      if file.type != ''
        file.type
      else
        'application/octet-stream'

    upload: (files, key, acl, callback) ->
      $http.get(AWS_PROPERTIES_PATH).success((data) =>
        policy = data['policy']
        signature = data['signature']

        for file in files
          Upload.upload(
            url: URL,
            method: 'POST',
            fields: {
              key: key(file),
              AWSAccessKeyId: window.Config.aws.access_key_id,
              acl: acl,
              policy: policy,
              signature: signature,
              "Content-Type": @contentType(file),
              filename: file.name
            },
            file: file,
          ).success(callback)
      )
]
