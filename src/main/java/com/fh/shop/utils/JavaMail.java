package com.fh.shop.utils;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class JavaMail {

    public static void email(String subject,String text,String recipient) throws Exception {
        Properties props = new Properties();
        props.setProperty("mail.smtp.auth", "true");
        props.setProperty("mail.transport.protocol", "smtp");
        props.put("mail.smtp.host","smtp.qq.com");// smtp服务器地址
        Session session = Session.getInstance(props);
        session.setDebug(true);
        Message msg = new MimeMessage(session);
        msg.setSubject(subject);
        msg.setText(text);
        msg.setFrom(new InternetAddress("1594558281@qq.com"));//发件人邮箱(我的163邮箱)
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //收件人邮箱(我的QQ邮箱)
        msg.saveChanges();
        Transport transport = session.getTransport();
        transport.connect("1594558281@qq.com","enbloobjkjczbgff");//发件人邮箱,授权码(可以在邮箱设置中获取到授权码的信息)
        transport.sendMessage(msg, msg.getAllRecipients());
        System.out.println("邮件发送成功...");
        transport.close();
    }


}
