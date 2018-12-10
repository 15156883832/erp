package com.jojowonet.modules.fmss.web;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
 
public class CsvUtil {
        private String fileName = null;
        private BufferedReader br = null;
        private List<String> list = new ArrayList<String>();
 
        public CsvUtil() {
 
        }
 
        public CsvUtil(String fileName) throws Exception {
                this.fileName = fileName;
                br = new BufferedReader(new FileReader(fileName));
                String stemp;
                while ((stemp = br.readLine()) != null) {
                        list.add(stemp);
                }
        }
 
        public List getList() {
                return list;
        }
        /**
         * 获取行数
         * @return
         */
        public int getRowNum() {
                return list.size();
        }
        /**
         * 获取列数
         * @return
         */
        public int getColNum() {
                if (!list.toString().equals("[]")) {
                        if (list.get(0).toString().contains(",")) {// csv为逗号分隔文件
                                return list.get(0).toString().split(",").length;
                        } else if (list.get(0).toString().trim().length() != 0) {
                                return 1;
                        } else {
                                return 0;
                        }
                } else {
                        return 0;
                }
        }
        /**
         * 获取制定行
         * @param index
         * @return
         */
        public String getRow(int index) {
                if (this.list.size() != 0) {
                        return (String) list.get(index);
                } else {
                        return null;
                }
        }
        /**
         * 获取指定列
         * @param index
         * @return
         */
        @SuppressWarnings("rawtypes")
		public String getCol(int index) {
                if (this.getColNum() == 0) {
                        return null;
                }
                StringBuffer sb = new StringBuffer();
                String tmp = null;
                int colnum = this.getColNum();
                if (colnum > 1) {
                        for (Iterator it = list.iterator(); it.hasNext();) {
                                tmp = it.next().toString();
                                sb = sb.append(tmp.split(",")[index] + ",");
                        }
                } else {
                        for (Iterator it = list.iterator(); it.hasNext();) {
                                tmp = it.next().toString();
                                sb = sb.append(tmp + ",");
                        }
                }
                String str = new String(sb.toString());
                str = str.substring(0, str.length() - 1);
                return str;
        }
        /**
         * 获取某个单元格
         * @param row
         * @param col
         * @return
         */
        public String getString(int row, int col) {
                String temp = null;
                int colnum = this.getColNum();
                if (colnum > 1) {
                        temp = list.get(row).toString().split(",")[col];
                } else if(colnum == 1){
                        temp = list.get(row).toString();
                } else {
                        temp = null;
                }
                return temp;
        }
         
        public void CsvClose()throws Exception{
                this.br.close();
        }
        public static void main(String[] args)throws Exception {
                CsvUtil util = new CsvUtil("F:\\2345下载\\export.csv");
                int rowNum = util.getRowNum();
                int colNum = util.getColNum();
                String x = util.getRow(2);
            //    String y = util.getCol(2);

                for(int i=1;i<rowNum;i++){
                        for(int j=0;j<colNum;j++){
                        }
                }
                 
        }
}