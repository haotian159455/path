package com.fh.shop.controller.user;

import com.alibaba.fastjson.JSONObject;
import com.fh.shop.aspect.LogMessage;
import com.fh.shop.biz.menu.MenuServiceImpl;
import com.fh.shop.biz.user.IUserService;
import com.fh.shop.commen.Datetables;
import com.fh.shop.commen.ResponseEnum;
import com.fh.shop.commen.ServerResponse;
import com.fh.shop.commen.SystemConstant;
import com.fh.shop.param.menu.MenuParam;
import com.fh.shop.param.user.UserParam;
import com.fh.shop.param.user.UserParamPassword;
import com.fh.shop.po.menu.Menu;
import com.fh.shop.po.user.User;
import com.fh.shop.servlet.DistributedSession;
import com.fh.shop.servlet.KeyUtil;
import com.fh.shop.utils.DateUtil;
import com.fh.shop.utils.JavaMail;
import com.fh.shop.utils.Md5Util;
import com.fh.shop.utils.RedisUtil;
import com.fh.shop.vo.user.UserVo;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.List;


import sun.misc.BASE64Encoder;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private IUserService userService;
    @Autowired
    private MenuServiceImpl menuService;
    @RequestMapping("toAddUser")
    public String toAddUser(){
        return "user/addUser";
    }

    @RequestMapping("addUser")
    @LogMessage("这是用户增加方法!!")
    @ResponseBody
    public ServerResponse addUser(User user){
        try {
            userService.addUser(user);
            return ServerResponse.success(user);
        } catch (Exception e) {
            e.printStackTrace();
            return  ServerResponse.error();
        }
    }

    @RequestMapping("toSelectList")
    public String toSelectList(){
        return "user/userList";
    }

    @RequestMapping("selectUser")
    @LogMessage("这是用户查询方法!!")
    @ResponseBody
    public Datetables selectUser(UserParam userParam){
       //查询总条数
       Long  count= userService.selectCount(userParam);
       //查询分页信息
       List<UserVo> list= userService.selectUser(userParam);
       return new Datetables(userParam .getDraw(),count,count,list);
    }

    @RequestMapping("deleteUser")
    @LogMessage("这是用户删除方法!!")
    @ResponseBody
    public ServerResponse deleteUser(Integer id){
        try {
            userService.deleteUser(id);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("selectUserById")
    @LogMessage("这是用户回显方法!!")
    @ResponseBody
    public  ServerResponse  selectUserById(Integer id){
        try {
            UserVo userVo = userService.selectUserById(id);
            return ServerResponse.success(userVo);
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();

        }
    }

    @RequestMapping("updateUser")
    @LogMessage("这是用户修改方法!!")
    @ResponseBody
    public ServerResponse updateUser(User user){
        try {
            userService.updateUser(user);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
        }

    @RequestMapping("deleteBatch")
    @LogMessage("这是用户批量删除方法!!")
    @ResponseBody
    public ServerResponse deleteBatch(@RequestParam("ids[]") List<Integer> list){
        try {
            userService.deleteBatch(list);
            return ServerResponse.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error();
        }
    }

    @RequestMapping("loginOut")
    @LogMessage("这是用户退出方法!!")
    public String loginOut(HttpServletRequest request,HttpServletResponse response){
        String sessionId = DistributedSession.getSessionId(request, response);
        RedisUtil.del(KeyUtil.menu(sessionId),
                KeyUtil.menu1(sessionId),
                KeyUtil.allMenu(sessionId),
                KeyUtil.menuIn(sessionId),
                KeyUtil.user(sessionId));
        return "redirect:/";
    }

    @RequestMapping("confirmUserName")
    @ResponseBody
    public Map confirmUserName(String add_userName){
      Map<String,Boolean> result=new HashMap();
      User user=userService.confirmUserName(add_userName);
      if (user==null){
          result.put("valid",true);
      }else{
          result.put("valid",false);
      }
       return result;
    }

    @RequestMapping("toPassword")
    public String toPassword(){
        return  "user/userPassword";
    }

    @RequestMapping("login")
    @LogMessage("这是用户登录方法!!")
    @ResponseBody
    public ServerResponse login(User user,HttpServletRequest request,String imgCode,HttpServletResponse response){
        String  userName = user.getUserName();
        String  password = user.getPassword();
        if (userName=="" || password=="" || imgCode== ""){
            return ServerResponse.error(ResponseEnum.USERNAME_USERPWD_IS_EMPTY);
        }
        String sessionId = DistributedSession.getSessionId(request, response);
        String checkcode = RedisUtil.get(KeyUtil.buildCodeKey(sessionId));
        if (!imgCode.equalsIgnoreCase(checkcode)){
            return ServerResponse.error(ResponseEnum.IMGCOUDE_NO);
        }
        try {
            User user1=userService.selectUserByName(user);
            String   a=DateUtil.date2str(new Date(),DateUtil.Y_M_D);
            String   b=DateUtil.date2str(user1.getDqTime(),DateUtil.Y_M_D);
            if (user1==null){
                return ServerResponse.error(ResponseEnum.USERNAME_IS_ERROR);
            }
            if (user1.getIsLock()==1 && user1.getLockTime()!=null&&a.equals(DateUtil.date2str(user1.getLockTime(),DateUtil.Y_M_D))){
                return ServerResponse.error(ResponseEnum.USERPWD_IS_LOCK);
            }
            if (user1.getErrorCount()==3){
                JavaMail.email("账号安全提醒","你的账号已被锁定",user1.getEmail());
                user1.setIsLock((long)1);
                user1.setErrorCount((long)0);
                user1.setLockTime(new Date());
                userService.updateErrorCount(user1);
                return ServerResponse.error(ResponseEnum.USERPWD_IS_LOCK);
            }
            if (!user1.getPassword().equals(Md5Util.md5(password))){
                user1.setErrorCount(user1.getErrorCount()+1);
                userService.updateErrorCount(user1);
                return ServerResponse.error(ResponseEnum.USERPWD_IS_ERROR);
            }
           if(user1.getDqTime()==null){
               user1.setLoginCount((long)1);
           }else if (a.equals(b)){
                user1.setLoginCount(user1.getLoginCount()+1);
            }else{
                user1.setLoginCount((long)1);
            }
            user1.setScTime(user1.getDqTime());
            user1.setDqTime(new Date());
            userService.updateLoginUser(user1);
            if (user1.getLockTime()!=null&&a.equals(DateUtil.date2str(user1.getLockTime(),DateUtil.Y_M_D))){
                user1.setIsLock((long)0);
                user1.setErrorCount((long)0);
                user1.setLockTime(null);
                userService.updateErrorCount(user1);
            }
            user1.setErrorCount((long)0);
            userService.updateErrorCount(user1);
             //通过 用户id 查询 菜单表所有的菜单 以及每个用户菜单对应下的按钮
            List<Menu> menu1= menuService.selectMenuList3(user1.getId());
            String s = JSONObject.toJSONString(menu1);
            RedisUtil.sexEx(KeyUtil.menu1(sessionId),s, com.fh.shop.utils.SystemConstant.USER_SHIJIAN);

            List<MenuParam> menu= userService.selectMenu(user1.getId());
            String s1 = JSONObject.toJSONString(menu);
            RedisUtil.sexEx(KeyUtil.menu1(sessionId),s1,com.fh.shop.utils.SystemConstant.USER_SHIJIAN);

            List<Menu>  allMenu= menuService.selectMenuList2();
            String s2 = JSONObject.toJSONString(allMenu);
            RedisUtil.sexEx(KeyUtil.allMenu(sessionId),s2,com.fh.shop.utils.SystemConstant.USER_SHIJIAN);

            List<Menu> menuIn= userService.selectMenuIn(user1.getId());
            String s3 = JSONObject.toJSONString(menuIn);
            String s4 = JSONObject.toJSONString(user1);
            RedisUtil.sexEx(KeyUtil.menuIn(sessionId),s3,com.fh.shop.utils.SystemConstant.USER_SHIJIAN);
            RedisUtil.sexEx(KeyUtil.user(sessionId),s4,com.fh.shop.utils.SystemConstant.USER_SHIJIAN);
            //删除验证码
            RedisUtil.del(KeyUtil.buildCodeKey(sessionId));
            return ServerResponse.success(ResponseEnum.SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return ServerResponse.error(ResponseEnum.ERROR);
        }
    }
    //修改密码
    @RequestMapping("updatePassword")
    @ResponseBody
    public ServerResponse updatePassword(UserParamPassword userParamPassword){
       

        return null;
    }


    @RequestMapping("exportExcel")
    public void exportExcel(UserParam userParam,HttpServletResponse response){
        List<User> list=userService.selectList(userParam);
        int count =list.size();
        int sheetcount = 0;
        if (count%2==0) {
            sheetcount = count/2;
        }else{
            sheetcount = count/2+1;
        }
        XSSFWorkbook xss = new XSSFWorkbook();
        for (int j = 0; j < sheetcount; j++) {
            XSSFSheet sheet = xss.createSheet("用户"+j);
            int num = 0;
            for (int i = (j*2); i <=((j+1)*2-1); i++) {
                if (i==list.size()) {
                    break;
                }
                User temp = list.get(i);
                //创建第一行
                XSSFRow row = sheet.createRow(num);
                num = num+1;
                //创建第一行第一列id,userName,realName,sex,age,phone,email,salary,comeTime
                XSSFCell cell1 = row.createCell(0);
                //给第一行第一列赋值
                cell1.setCellValue(temp.getUserName());
                //创建第一行第二列
                XSSFCell cell2 = row.createCell(1);
                //给第一行第二列赋值
                cell2.setCellValue(temp.getRealName());
                //创建第一行第三列
                XSSFCell cell3 = row.createCell(2);
                //给第一行第三列赋值
                cell3.setCellValue(temp.getSex()==1?"男":"女");

                XSSFCell cell5 = row.createCell(3);
                cell5.setCellValue(temp.getAge());

                XSSFCell cell6 = row.createCell(4);
                cell6.setCellValue(temp.getPhone());

                XSSFCell cell7 = row.createCell(5);
                cell7.setCellValue(temp.getEmail());

                XSSFCell cell8 = row.createCell(6);
                cell8.setCellValue(temp.getSalary());

                XSSFCell cell4 = row.createCell(7);
                SimpleDateFormat sim=new SimpleDateFormat("yyyy-MM-dd");
                cell4.setCellValue(sim.format(temp.getComeTime()));

            }
        }

        //下载文件
        response.setCharacterEncoding("utf-8");
        response.setContentType("application/octet-stream");
        //设置响应文件的名称
        response.setHeader("Content-Disposition", "attachment;filename="+UUID.randomUUID().toString()+".xlsx");
        //创建输出流
        try {
            ServletOutputStream  out = response.getOutputStream();
            xss.write(out);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    @RequestMapping("exportPdf")
    public void exportPdf(UserParam userParam,HttpServletRequest req,HttpServletResponse response){
        String realPath = req.getSession().getServletContext().getRealPath(File.separator);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            // 第一步，实例化一个document对象
            Document document = new Document();
            // 第二步，设置要到出的路径
            response.setCharacterEncoding("utf-8");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + UUID.randomUUID().toString() + ".pdf");
            ServletOutputStream out = response.getOutputStream();
            // 如果是浏览器通过request请求需要在浏览器中输出则使用下面方式
            // OutputStream out = response.getOutputStream();
            // 第三步,设置字符
            BaseFont bfChinese = BaseFont.createFont("C:/windows/fonts/simsun.ttc,1", BaseFont.IDENTITY_H,
                    BaseFont.EMBEDDED);
            Font fontZH = new Font(bfChinese, 12.0F, 0);
            // 第四步，将pdf文件输出到磁盘
            PdfWriter writer = PdfWriter.getInstance(document, out);
            // 第五步，打开生成的pdf文件
            document.open();
            // 第六步,设置内容
            String title = "导出用户pdf的情况";
            document.add(new Paragraph(new Chunk(title, fontZH).setLocalDestination(title)));
            document.add(new Paragraph("\n"));
            // 创建table,注意这里的2是两列的意思,下面通过table.addCell添加的时候必须添加整行内容的所有列
            PdfPTable table = new PdfPTable(11);
            table.setWidthPercentage(100.0F);
            // 第一列是列表名
            table.setHeaderRows(1);
            table.getDefaultCell().setHorizontalAlignment(1);
            table.addCell(new Paragraph("ID", fontZH));
            table.addCell(new Paragraph("真实姓名", fontZH));
            table.addCell(new Paragraph("用户名", fontZH));
            table.addCell(new Paragraph("年龄", fontZH));
            table.addCell(new Paragraph("性别", fontZH));
            table.addCell(new Paragraph("手机号", fontZH));
            table.addCell(new Paragraph("邮箱", fontZH));
            table.addCell(new Paragraph("薪水", fontZH));
            table.addCell(new Paragraph("入职时间", fontZH));
            table.addCell(new Paragraph("图片", fontZH));
            List<User> list=userService.selectList(userParam);
            for (int i = 0; i < list.size(); i++) {
                table.addCell(new Paragraph("" + (list.get(i).getId()), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getRealName(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getUserName(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getAge(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getSex()=="1"?"男":"女", fontZH));
                table.addCell(new Paragraph("" + list.get(i).getPhone(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getEmail(), fontZH));
                table.addCell(new Paragraph("" + list.get(i).getSalary(), fontZH));
                table.addCell(new Paragraph(sdf.format(list.get(i).getComeTime()), fontZH));
                table.addCell(Image.getInstance(realPath + list.get(i).getImgPath()));
            }
            document.add(table);
            document.add(new Paragraph("\n"));
            // 第七步，关闭document
            document.close();
            writer.close();
            System.out.println("导出pdf成功~");
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

//    @RequestMapping("exportWord")
//    public void exportWord(UserParam userParam,HttpServletRequest req,HttpServletResponse response) throws IOException, TemplateException {
//        String imgFile = null;

//        InputStream in = null;//        byte[] data = null;
//        String realPath = req.getSession().getServletContext().getRealPath("/");
//        Configuration configuration = new Configuration(Configuration.getVersionNumber());
//        // 第二步：设置模板文件所在的路径。
//        configuration.setClassForTemplateLoading(this.getClass(), "/doc");
//        // 第三步：设置模板文件使用的字符集。一般就是utf-8.
//        configuration.setDefaultEncoding("utf-8");
//        // 第四步：加载一个模板，创建一个模板对象。
//        Template template = configuration.getTemplate("user.ftl");
//        // 第五步：创建一个模板使用的数据集，可以是pojo也可以是map。一般是Map。
//        Map<String, Object> map = new HashMap<>();
//        List<User> list=userService.selectList(userParam);
//        BASE64Encoder encoder = new BASE64Encoder();
//        for (int i = 0; i < list.size(); i++) {
//            imgFile = list.get(i).getImgPath();
//            try {
//                in = new FileInputStream(realPath + imgFile);
//            } catch (FileNotFoundException e) {
//                e.printStackTrace();
//            }
//            data = new byte[in.available()];
//            in.read(data);
//            in.close();
//            list.get(i).setImgPath(encoder.encode(data));
//        }
//        map.put("list", list);
//        // 第六步：创建一个Writer对象，一般创建一FileWriter对象，指定生成的文件名。
//        response.setCharacterEncoding("utf-8");
//        response.setContentType("application/x-download");
//        response.addHeader("Content-Disposition", "attachment;filename=" + UUID.randomUUID().toString() + ".doc");
//        PrintWriter writer = response.getWriter();
//        // 第七步：调用模板对象的process方法输出文件。
//        template.process(map,writer);
//        // 第八步：关闭流。
//        writer.close();
//    }
//     @RequestMapping("exportWord")
//    public void exportWord() {
//         userService.selectUserByName(user);
//     }
}