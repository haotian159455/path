package com.fh.shop.controller;

import com.fh.shop.commen.ServerResponse;
import com.fh.shop.oss.OSSUtil;
import com.fh.shop.utils.FileUtil;
import com.fh.shop.utils.SystemConstant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

@Controller
@RequestMapping("/file")
public class FileController {

    @RequestMapping("/uploadFile")
    @ResponseBody
    public ServerResponse uploadFile(@RequestParam MultipartFile uploadFileInfo) throws IOException {
        // 将文件从客户端到服务端上传的工作，框架已经帮你做了
        // 你写的代码只是做了一个复制文件并且重命名的操作
        // 上传时候的路径是 绝对路径
        String uploadFileName = FileUtil.copyFile(uploadFileInfo.getInputStream(), uploadFileInfo.getOriginalFilename(), SystemConstant.UPLOAD_FILE_PATH);
        return ServerResponse.success(SystemConstant.UPLOAD_FILE_PATH+uploadFileName);
    }

    @RequestMapping("/uploadImage")
    @ResponseBody
    public ServerResponse uploadImage(@RequestParam MultipartFile imageInfo, HttpServletRequest request) throws IOException {
        // 将文件从客户端到服务端上传的工作，框架已经帮你做了
        // 你写的代码只是做了一个复制文件并且重命名的操作
        // 上传时候的路径是 绝对路径,但是存储在数据库表中的路径是 相对路径
        // 相对于咱们项目的webapp来说的
        // 将相对于webapp文件夹的路径转为 绝对路径，通过getRealPath();
        String path = request.getServletContext().getRealPath(SystemConstant.UPLOAD_IMAGE_PATH);
        String uploadFileName = FileUtil.copyFile(imageInfo.getInputStream(), imageInfo.getOriginalFilename(), path);
        return ServerResponse.success(SystemConstant.UPLOAD_IMAGE_PATH+uploadFileName);
    }

    @RequestMapping("update")
    @ResponseBody
    public ServerResponse update(@RequestParam MultipartFile files) throws IOException {
        String filePath = OSSUtil.uploadFile(files.getInputStream(), files.getOriginalFilename());
        return ServerResponse.success(filePath);
    }

}
