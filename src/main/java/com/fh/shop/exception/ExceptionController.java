package com.fh.shop.exception;

import com.fh.shop.commen.ServerResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice
@ResponseBody
public class ExceptionController {

    @ExceptionHandler(Exception.class)
    public ServerResponse getException(Exception ex){
        ex.printStackTrace();
        return ServerResponse.error();
    }
}
