package com.fh.shop.email;

public class MailTest {

    public static void main(String[] args) {

        MailOperation operation = new MailOperation();
        String user = "516336670@qq.com";//邮箱地址
        String MailPassword = "enbloobjkjczbgff";//邮箱授权码
        String host = "smtp.qq.com";//SMTP服务器主机地址
        String from = "516336670@qq.com";//邮箱地址,与上边的user是同一个
        String to = "532028476@qq.com";// 收件人的邮箱
        String subject = "孔令波";//输入邮件主题
        //邮箱内容
        StringBuffer sb = new StringBuffer();
        sb.append("<!DOCTYPE><div bgcolor='#f1fcfa' style='border:1px solid #d9f4ee; font-size:14px; line-height:22px; color:#005aa0;padding-left:1px;padding-top:5px; padding-bottom:5px;'>"
                + "<h1 style='color:pink'>"
                + "欢迎来到飞狐教育"
                + "</h1>"

                + "</div>");
        try {
            String res = operation.sendMail(user, MailPassword, host, from, to,
                    subject, sb.toString());
            System.out.println(res);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
