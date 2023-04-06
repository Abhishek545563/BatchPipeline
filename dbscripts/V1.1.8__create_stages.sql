CREATE OR REPLACE PROCEDURE create_stages()
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
  var s3SecretKey = '';
  var s3AccessKey = '';
  var OrdersFilePath = '';
  var CustomerFilePath = '';
  var ItemFilePath = '';
  
  var getAwsCredentials = `SELECT PROP_NAME, PROP_VALUE FROM 
                           LEAPLOGIC.CONFIG.PIPELINE_PROPERTIES
                           WHERE PROP_NAME IN ('AWS_SECRET_KEY', 'AWS_ACCESS_KEY', 
						   'ORDERS_FILE_PATH','CUSTOMER_FILE_PATH', 'ITEM_FILE_PATH')`;
  var awsCredsStmt = snowflake.createStatement({sqlText: getAwsCredentials});
  var getAwsCreds = awsCredsStmt.execute();
  
  while (getAwsCreds.next()) {
    var prop_name = getAwsCreds.getColumnValue(1);
    var prop_value = getAwsCreds.getColumnValue(2);
    if (prop_name === 'AWS_SECRET_KEY') {
      s3SecretKey = prop_value;
    } else if (prop_name === 'AWS_ACCESS_KEY') {
      s3AccessKey = prop_value;
	} else if (prop_name ==='ORDERS_FILE_PATH') {
	  OrdersFilePath = prop_value;
	} else if (prop_name ==='CUSTOMER_FILE_PATH') {
	  CustomerFilePath = prop_value;
	} else if (prop_name ==='ITEM_FILE_PATH') {
	  ItemFilePath = prop_value;
	}
  }

  var ordersLoad = `CREATE OR REPLACE STAGE DELTA_ORDERS_S3
						  URL='${OrdersFilePath}'	
                          CREDENTIALS=(AWS_KEY_ID='${s3AccessKey}' AWS_SECRET_KEY='${s3SecretKey}')`;
						  
  var customerLoad = `CREATE OR REPLACE STAGE DELTA_CUSTOMER_S3
						  URL='${CustomerFilePath}'	
                          CREDENTIALS=(AWS_KEY_ID='${s3AccessKey}' AWS_SECRET_KEY='${s3SecretKey}')`;

  var itemLoad = `CREATE OR REPLACE STAGE DELTA_ITEMS_S3
						  URL='${ItemFilePath}'	
                          CREDENTIALS=(AWS_KEY_ID='${s3AccessKey}' AWS_SECRET_KEY='${s3SecretKey}')`;						  

  var ordersLoadSql = snowflake.createStatement({sqlText: ordersLoad});
  var customerLoadSql = snowflake.createStatement({sqlText: customerLoad});
  var itemLoadSql = snowflake.createStatement({sqlText: itemLoad});

  ordersLoadSql.execute();
  customerLoadSql.execute();
  itemLoadSql.execute();

  return 'Stage created successfully';
$$;