package com.jojowonet.modules.fmss.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jfinal.plugin.activerecord.Record;
import com.jojowonet.modules.order.service.OrderService;
import com.jojowonet.modules.order.utils.CrmUtils;
import com.jojowonet.modules.order.utils.Result;
import com.jojowonet.modules.order.utils.ServletUtils;
import com.sf.file.core.template.SfFileTemplate;

import ivan.common.config.Global;
import ivan.common.entity.mysql.common.User;
import ivan.common.utils.DateUtils;
import ivan.common.utils.IdGen;
import ivan.common.utils.StringUtils;
import ivan.common.utils.UserUtils;

@Controller
@RequestMapping(value = "${adminPath}/download" )
public class DownloadController {

	@Resource
	private SfFileTemplate sfFileTemplate;
	
	@Autowired
	private OrderService orderService;
	private static final int  BUFFER_SIZE = 2 * 1024;
	
	   public static void createImage(String imgurl, String filePath) throws Exception {
	    	 
			URL url = new URL(imgurl);
	 
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			InputStream inputStream = conn.getInputStream(); // 通过输入流获得图片数据
			byte[] buffer = new byte[1024];
			int len = 0;
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			while ((len = inputStream.read(buffer)) != -1) {
				bos.write(buffer, 0, len);
			}
			bos.close();
			byte[] getData = bos.toByteArray(); // 获得图片的二进制数据
			
			File imageFile = new File(filePath);
			FileOutputStream fos = new FileOutputStream(imageFile);
			fos.write(getData);
			fos.close();
		}
	   
	   @RequestMapping("DownloadOrderFeedbackImg")
	    public Object download(HttpServletRequest request, HttpServletResponse response) throws IOException{
			String orderId = request.getParameter("orderId");
			String siteId = request.getParameter("siteId");
			if(StringUtils.isBlank(orderId)) {
					return null;
			}else if(StringUtils.isBlank(siteId)) {
				User user = UserUtils.getUser();
				siteId = CrmUtils.getCurrentSiteId(user);
			}
			 /** 1.创建临时文件夹  */
			 String rootPath = request.getSession().getServletContext().getRealPath("/");
			 String uuId = IdGen.uuid();
			 String name = rootPath + "userfiles/" + uuId;
			 File temDir = new File(name);
			 if(!temDir.exists()){
			  temDir.mkdirs();
			 }
			 String fileName = uuId+".zip";//需要下载的文件名
			 DownloadOrderFeedbackImg(rootPath,orderId,siteId,name,temDir,fileName);
			 //下载压缩文件
		       //文件的目录
		     String realPath = rootPath + File.separator + "userfiles" + File.separator + fileName;
		      File downloadFile = new File(realPath);
		        if(!downloadFile.exists()){
		            response.getWriter().write(" 下载失败，无图片下载 !");
		            return null;
		        }
		        BufferedInputStream bis = null;
		        BufferedOutputStream bos = null;
		        OutputStream fos = null;
		        InputStream fis = null;
		        try {
		            fis = new FileInputStream(downloadFile);
		            bis = new BufferedInputStream(fis);
		            fos = response.getOutputStream();
		            bos = new BufferedOutputStream(fos);
		            ServletUtils.setFileDownloadHeader(request,response, fileName);
		            int byteRead = 0;
		            byte[] buffer = new byte[8192];
		            while((byteRead=bis.read(buffer,0,8192))!=-1){
		                bos.write(buffer,0,byteRead);
		            }
		            bos.flush();
		            fis.close();
		            bis.close();
		            fos.close();
		            bos.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		            response.getWriter().write("下载失败 !");
		        }finally{
		            // 删除临时文件和文件夹
					deleteFile(downloadFile);
		        }
				return null;
	    }
	   
	   /**
	     * 下载图片并打包
	     * @param rootPath 源文件
	     * @param orderId       
	     * @param siteId       
	     * @param name       生成压缩文件目录
	     * @param downName       压缩后的名称
	     * @throws Exception
	     */
		public void DownloadOrderFeedbackImg(String rootPath,String orderId,String siteId,String name,File temDir,String downName) {
		   String imgurl =  Global.getConfig("sended.process.img.url");
			if(StringUtils.isBlank(imgurl)) {
				imgurl = "http://www.sifangerp.cn/sfimggroup/";
			}
			String fileurl = "";
			try {
			List<Record> rds = orderService.getDownOrderFeedback(orderId, siteId);
				for(Record rd : rds) {
					Date time = rd.getDate("feedback_time");
					String folderName = DateUtils.formatDate(time, "yyyyMMddHHmmss");//日期文件夹名称
					fileurl = temDir.getPath() +"/"+ folderName;
					String img = rd.getStr("feedback_img");
					File file = new File(fileurl);
					if(StringUtils.isNotBlank(img)) {
						if(!file.exists()){//如果文件夹不存在
							file.mkdirs();//创建文件夹
						}
						String[] feimg = img.split(",");
						for(int i=0;i<feimg.length;i++) {
							String fileName = folderName+"-"+i;
							String suffix = FilenameUtils.getExtension(feimg[i]);//图片后缀
							String imgq = feimg[i].replaceAll("\\\\", "/");
							String filePath = fileurl +"/" + fileName + "." + suffix;
							createImage(imgurl+imgq, filePath);
						}
					}
				}
				if(temDir.exists()){//如果文件夹存在
				FileOutputStream fos1 = new FileOutputStream(new File(rootPath+"userfiles/"+downName));
				//将文件夹打包
				toZip(temDir.getPath(), fos1,true);
				//删除临时文件
				deleteFile(temDir);
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		
		/*删除文件
		*/
		public static boolean deleteFile(File dirFile) { 
			// 如果dir对应的文件不存在，则退出 
			if (!dirFile.exists()) { 
				return false; 
				} 
			if (dirFile.isFile()) { 
					return dirFile.delete(); 
				} else { 
					for (File file : dirFile.listFiles()) { 
						deleteFile(file); 
						} 
				} 
			return dirFile.delete(); 		
		}

	   public static void main(String[] args) throws Exception {
		   FileOutputStream fos1 = new FileOutputStream(new File("E:/home/mytest01.zip"));
		   toZip("E:/log", fos1,true);
	}
	   
	   
	    public static void toZip(String srcDir, OutputStream out, boolean KeepDirStructure)
	            throws RuntimeException{
	      //  long start = System.currentTimeMillis();
	        ZipOutputStream zos = null ;
	        try {
	            zos = new ZipOutputStream(out);
	            File sourceFile = new File(srcDir);
	            compress(sourceFile,zos,sourceFile.getName(),KeepDirStructure);
	           // long end = System.currentTimeMillis();
	            //System.out.println("压缩完成，耗时：" + (end - start) +" ms");
	        } catch (Exception e) {
	            throw new RuntimeException("zip error from ",e);
	        }finally{
	            if(zos != null){
	                try {
	                    zos.close();
	                } catch (IOException e) {
	                    e.printStackTrace();
	                }
	            }
	        }
	    }
	    /**
	     * 递归压缩方法
	     * @param sourceFile 源文件
	     * @param zos        zip输出流
	     * @param name       压缩后的名称
	     * @param KeepDirStructure  是否保留原来的目录结构,true:保留目录结构; 
	     * false:所有文件跑到压缩包根目录下(注意：不保留目录结构可能会出现同名文件,会压缩失败)
	     * @throws Exception
	     */
	    private static void compress(File sourceFile, ZipOutputStream zos, String name,
	            boolean KeepDirStructure) throws Exception{
	        byte[] buf = new byte[BUFFER_SIZE];
	        if(sourceFile.isFile()){
	            // 向zip输出流中添加一个zip实体，构造器中name为zip实体的文件的名字
	            zos.putNextEntry(new ZipEntry(name));
	            // copy文件到zip输出流中
	            int len;
	            FileInputStream in = new FileInputStream(sourceFile);
	            while ((len = in.read(buf)) != -1){
	                zos.write(buf, 0, len);
	            }
	            zos.closeEntry();
	            in.close();
	        } else {
	            File[] listFiles = sourceFile.listFiles();
	            if(listFiles == null || listFiles.length == 0){
	                // 需要保留原来的文件结构时,需要对空文件夹进行处理
	                if(KeepDirStructure){
	                    // 空文件夹的处理
	                    zos.putNextEntry(new ZipEntry(name + "/"));
	                    // 没有文件，不需要文件的copy
	                    zos.closeEntry();
	                }
	            }else {
	                for (File file : listFiles) {
	                    // 判断是否需要保留原来的文件结构
	                    if (KeepDirStructure) {
	                        // 注意：file.getName()前面需要带上父文件夹的名字加一斜杠,
	                        // 不然最后压缩包中就不能保留原来的文件结构,即：所有文件都跑到压缩包根目录下了
	                        compress(file, zos, name + "/" + file.getName(),KeepDirStructure);
	                    } else {
	                        compress(file, zos, file.getName(),KeepDirStructure);
	                    }
	                }
	            }
	        }
	    }


}
