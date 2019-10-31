package com.fh.shop.oss;

import com.aliyun.oss.ClientException;
import com.aliyun.oss.OSS;
import com.aliyun.oss.OSSClientBuilder;
import com.aliyun.oss.OSSException;
import com.fh.shop.utils.DateUtil;
import org.springframework.stereotype.Component;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.UUID;

@Component
public class OSSUtil {

    private static String endpoint = "http://oss-cn-beijing.aliyuncs.com";
    private static String accessKeyId = "LTAI4FmdNicuRzZxcrED9Ejj";
    private static String accessKeySecret = "w5egklCZwlX3u00gd4PnKwKhk5qT6m";
    private static String bucketName = "1231521";
    private static String ossUrl = "oss-cn-beijing-internal.aliyuncs.com";


    public static String uploadFile(String fileName) {
        InputStream inputStream = null;
        OSS ossClient = null;
        String path = "";
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            //new一个当前时间作为文件夹目录,拼接到路径中
            String dateStr = DateUtil.dateUtil(new Date(), DateUtil.Y_M_D).replace("-","");
            // 上传文件流。
            inputStream = new FileInputStream(fileName);
            String uuidStr = UUID.randomUUID().toString().replace("-", "");
            String filePath = dateStr + "/" + uuidStr + getSuffix(fileName);
            ossClient.putObject(bucketName, filePath, inputStream);
            path = filePath;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            if (null != inputStream){
                try {
                    inputStream.close();
                    inputStream= null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != ossClient){
                ossClient.shutdown();
            }
        }
        return path;
    }

    public static String uploadFile(InputStream is,String fileName) {
        OSS ossClient = null;
        String path = "";
        try {
            // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            System.out.println(ossClient);
            //new一个当前时间作为文件夹目录,拼接到路径中
            String dateStr = DateUtil.dateUtil(new Date(), DateUtil.Y_M_D).replace("-","");
            String uuidStr = UUID.randomUUID().toString().replace("-", "");
            String filePath = dateStr + "/" + uuidStr + getSuffix(fileName);
            ossClient.putObject(bucketName, filePath, is);
            path = filePath;
        }  finally {
            if (null != is){
                try {
                    is.close();
                    is= null;
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (null != ossClient){
                ossClient.shutdown();
            }
        }
        return path;
    }

    private static String  getSuffix(String fileName){
        int i = fileName.lastIndexOf(".");
        String suffix = fileName.substring(i);
        return suffix;
    }

    public static void delFile(String fileName){
        OSS ossClient = null;
        try {
             // 创建OSSClient实例。
            ossClient = new OSSClientBuilder().build(endpoint, accessKeyId, accessKeySecret);
            // 删除文件。
            ossClient.deleteObject(bucketName, fileName.replace(ossUrl,""));
        } catch (OSSException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        } finally {
            if (null != ossClient){
                ossClient.shutdown();
            }
        }
    }


}
