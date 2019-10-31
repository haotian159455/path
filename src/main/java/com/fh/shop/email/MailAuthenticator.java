package com.fh.shop.email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MailAuthenticator extends   Authenticator{

    public static String USERNAME = "516336670";
    public static String PASSWORD = ".klb1009.";

    public MailAuthenticator() {
    }

    protected PasswordAuthentication getPasswordAuthentication() {
        return new PasswordAuthentication(USERNAME, PASSWORD);
    }

}
