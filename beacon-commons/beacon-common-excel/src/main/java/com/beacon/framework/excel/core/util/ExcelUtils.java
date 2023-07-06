package com.beacon.framework.excel.core.util;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.write.style.column.LongestMatchColumnWidthStyleStrategy;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

/**
 * Excel 工具类
 *
 * @author Beacon
 */
public class ExcelUtils {

    /**
     * 将列表以 Excel 响应给前端
     *
     * @param response 响应
     * @param filename 文件名
     * @param sheetName Excel sheet 名
     * @param head Excel head 头
     * @param data 数据列表哦
     * @param <T> 泛型，保证 head 和 data 类型的一致性
     * @throws IOException 写入失败的情况
     */
    public static <T> void write(HttpServletResponse response, String filename, String sheetName,
                                 Class<T> head, List<T> data) throws IOException {
        // 输出 Excel
        EasyExcel.write(response.getOutputStream(), head)
                .autoCloseStream(false) // 不要自动关闭，交给 Servlet 自己处理
                .registerWriteHandler(new LongestMatchColumnWidthStyleStrategy()) // 基于 column 长度，自动适配。最大 255 宽度
                .sheet(sheetName).doWrite(data);
        // 设置 header 和 contentType。写在最后的原因是，避免报错时，响应 contentType 已经被修改了
        response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
    }

    public static <T> List<T> read(MultipartFile file, Class<T> head) throws IOException {
       return EasyExcel.read(file.getInputStream(), head, null)
                .autoCloseStream(false)  // 不要自动关闭，交给 Servlet 自己处理
                .doReadAllSync();
    }

    /**
     * 根据参数提供的excel文件访问路径将其转换为响应流返回给前端
     * 可根据参数 isDelete 的值删除源文件
     *
     * @param fileName 文件访问路径
     * @param filePath 文件名称
     * @param response http请求的响应信息
     * @param isDelete 是否删除源文件
     */
    public static void downloadExcelFile(String filePath, String fileName, HttpServletResponse response, Boolean isDelete) throws IOException {

        //步骤一：初始化响应头信息
        //重置response
        response.reset();
        String fileNameUtf8 = URLEncoder.encode(fileName, "UTF-8");
        // 重要，设置response的Header
        response.setHeader("Content-disposition", "attachment;filename=" + fileNameUtf8 + ";" + "filename*=utf-8''" + fileNameUtf8);
        //response.setHeader("Content-Length", "" + file.length());
        //指定文件返回类
        response.setContentType("application/vnd.ms-excel");
        //跨域请求，*代表允许全部类型
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Expose-Headers", "Content-Disposition");
        //允许请求方式
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        //用来指定本次预检请求的有效期，单位为秒，在此期间不用发出另一条预检请求
        response.setHeader("Access-Control-Max-Age", "3600");
        //请求包含的字段内容，如有多个可用哪个逗号分隔如下
        response.setHeader("Access-Control-Allow-Headers", "content-type,x-requested-with,Authorization, x-ui-request,lang");
        //访问控制允许凭据，true为允许
        response.setHeader("Access-Control-Allow-Credentials", "true");
        //创建一个输出流，用于输出文件


        //步骤二：将文件转为流并回传给前端
        //将文件转化成文件流的形式
        try (
                InputStream in = Files.newInputStream(Paths.get(filePath + fileName));
                InputStream fis = new BufferedInputStream(in);
                OutputStream oStream = new BufferedOutputStream(response.getOutputStream())
        ) {
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            //写入输出文件
            oStream.write(buffer);
            oStream.flush();
        }

        //步骤三：如需删除源文件则删除
        if (isDelete) {
            new File(filePath + fileName).delete();
        }

    }

}
