package lambdas.dao;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDB;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClientBuilder;
import com.amazonaws.services.dynamodbv2.document.DynamoDB;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

public abstract class GeneralDAO {

    static boolean isNonEmptyString(String value) {
        return (value != null && value.length() > 0);
    }

    // DynamoDB client
    static AmazonDynamoDB amazonDynamoDB = AmazonDynamoDBClientBuilder
            .standard()
            .withRegion("us-west-2")
            .build();
    static DynamoDB dynamoDB = new DynamoDB(amazonDynamoDB);

    static AmazonS3Client s3Client = (AmazonS3Client) AmazonS3ClientBuilder.standard()
            .withRegion("us-west-2")
            .withCredentials(DefaultAWSCredentialsProviderChain.getInstance())
            .withPathStyleAccessEnabled(true)
            .build();

}
