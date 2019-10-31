package com.fh.shop.utils;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.xssf.usermodel.*;

import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExcelUtil  {

    public static XSSFWorkbook XSSF(List shopList, String sheetName, String[] headers, String[] props, Class clazz) {
        // 创建workbook
        XSSFWorkbook workbook = new XSSFWorkbook();
        // 创建sheet
        XSSFSheet sheet =  workbook.createSheet(sheetName);
        // 创建头部
        buildTitleHeader(sheet,headers);
        // 创建日期格式
        XSSFCellStyle cellStyle = workbook.createCellStyle();
        cellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("m/d/yy"));
        // 转换价格类型格式
        XSSFCellStyle sum =  workbook.createCellStyle();
        sum.setDataFormat(HSSFDataFormat.getBuiltinFormat("0.00"));
        // 把日期和价格放在map
        Map<String,XSSFCellStyle> styleMap = new HashMap<>();
        styleMap.put("cellStyle",cellStyle);
        styleMap.put("sum",sum);
        // 创建主题内容
        buildBody(shopList,sheet,props,clazz,styleMap);
        return workbook;
    }

    private static void buildBody(List shopList, XSSFSheet sheet, String[] props, Class clazz,Map<String,XSSFCellStyle>  styleMap) {
        for (int i = 0; i < shopList.size(); i++) {
            Object shop = shopList.get(i);
            XSSFRow row = sheet.createRow(i+1);
            buildBodyRow(row,shop,props,clazz,styleMap);
        }
    }

    private static void buildBodyRow(XSSFRow row, Object shop, String[] props,Class clazz,Map<String,XSSFCellStyle>  styleMap) {
        for (int i= 0;i<props.length ;i++){
            try {
                //获取指定名字的属性/字段
                String prop = props[i];
                Field declaredField = clazz.getDeclaredField(prop);
                // 强制访问
                declaredField.setAccessible(true);
                Object o = declaredField.get(shop);
                Class<?> type = declaredField.getType();
                if(type == java.lang.String.class){
                    row.createCell(i).setCellValue(String.valueOf(o));
                }
                if(type == java.lang.Long.class){
                    row.createCell(i).setCellValue(Long.valueOf(o.toString()));
                }
                if(type == java.lang.Integer.class){
                    row.createCell(i).setCellValue(Integer.valueOf(o.toString()));
                }
                if(type == java.util.Date.class){
                    XSSFCell cell = row.createCell(i);
                    cell.setCellValue((Date) o);
                    cell.setCellStyle(styleMap.get("cellStyle"));
                }
                if(type == java.math.BigDecimal.class){
                    XSSFCell cell = row.createCell(i);
                    cell.setCellValue(((BigDecimal)o).doubleValue());
                    cell.setCellStyle(styleMap.get("sum"));
                }
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }



    private static void buildTitleHeader(XSSFSheet sheet,String[] headers) {
        // 创建标题行
        XSSFRow row = sheet.createRow(0);
        // 为标题行赋值
        for (int i = 0; i < headers.length; i++) {
            row.createCell(i).setCellValue(headers[i]);
        }
    }

}
