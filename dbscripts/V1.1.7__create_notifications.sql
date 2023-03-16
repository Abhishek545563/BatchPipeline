CREATE OR REPLACE PROCEDURE create_notifications() 
RETURNS VARCHAR
LANGUAGE SQL
AS
$$
BEGIN

CREATE or replace NOTIFICATION INTEGRATION errornotificationsend
  ENABLED = true
  TYPE = QUEUE
  NOTIFICATION_PROVIDER = AWS_SNS
  DIRECTION = OUTBOUND
  AWS_SNS_TOPIC_ARN = 'arn:aws:sns:ap-south-1:630391088258:notification_failure_usecase'
  AWS_SNS_ROLE_ARN = 'arn:aws:iam::630391088258:role/snowpipe_error_notify_usecase';
  
 --DESC NOTIFICATION INTEGRATION errornotificationsend;

create or replace notification integration my_email
	type=email
    enabled=true
    allowed_recipients=('abhishek545563@gmail.com');

END
$$;