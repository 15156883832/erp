package com.jojowonet.modules.order.utils;

import java.io.*;
import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by yc on 2017/12/15.
 */
public class ReadlogExc {
    public static void  main(String args[])throws Exception{
      String eL= "(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)";
        Scanner in = new Scanner(new File("D:/Documents/Tencent Files/1570128553/FileRecv/prac.log"));
        PrintWriter out = new PrintWriter(new File("D:/Documents/Tencent Files/1570128553/FileRecv/pracExc.log"));
        while(in.hasNext()){
            String str = in.nextLine();
            String []ss = str.split(eL);
            for (int i = 0; i < ss.length - 1; i++) {
                String s = ss[i];
                if (s.length() > 1) {
                    Pattern pattern = Pattern.compile("^([0-5]\\d):([0-5]\\d):([0-5]\\d)$");
                    Matcher m = pattern.matcher(s.substring(1, 9));
                    if (!m.find()) {
                        out.write(ss[i-1] + "" + "\r\n");
                    }
                }
            }

           for (String s : ss) {
                if (s.length() > 1) {
                    Pattern pattern = Pattern.compile("^([0-5]\\d):([0-5]\\d):([0-5]\\d)$");
                    Matcher m = pattern.matcher(s.substring(1, 9));
                    if (!m.find()) {
                        out.write(s + "" + "\r\n");
                    }
                }
            }
        }
        out.close(); //关闭写入的文本
    }

    /*public static void Getlog(){
            String eL= "(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)";
        File file = new File("D:/Documents/Tencent Files/1570128553/FileRecv/prac.log");
        Reader reader = null;
        try {
            // 一次读一个字符
            reader = new InputStreamReader(new FileInputStream(file));
            int tempchar;
            while ((tempchar = reader.read()) != -1) {
                    String s1 = String.valueOf((char)tempchar);
                    String[] strArray = s1.split(eL);
                    for(String str:strArray){
                        if(str.length()>1){
                            Pattern pattern = Pattern.compile("^([0-5]\\d):([0-5]\\d):([0-5]\\d)$");
                            Matcher m = pattern.matcher(str.substring(1,9));
                            if(!m.find()){
                            }
                        }
                    }

            }
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();
        }*/


       /* File file = new File("D:/Documents/Tencent Files/1570128553/FileRecv/prac.log");
        Reader rd = null;
        try {
            rd = new InputStreamReader(new FileInputStream(file));
            char[] len = new char[1024];
            int temp = 0;
            while ((temp = rd.read(len))!=-1){
                if((temp == len.length) && (len[len.length - 1]!='\r')){
                    String s1 = new String(len);
                }else{
                    for(int i = 0 ; i<temp; i++){
                        if(len[i] == '\r'){
                            continue;
                        }else{
                        }
                    }
                }
            }
        } catch (Exception e){
            e.printStackTrace();
        }finally {
            if(rd !=null){
                try{
                    rd.close();
                }catch (IOException e){
                    e.printStackTrace();
                }
            }
        }
*/
    }


