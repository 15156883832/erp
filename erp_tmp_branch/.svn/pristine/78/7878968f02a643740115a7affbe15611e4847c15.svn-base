package com.jojowonet.modules.sys.service;

import com.jojowonet.modules.order.utils.excelExt.handler.ExcelAbstractHandler;
import org.junit.Assert;
import org.junit.Test;

public class SystemServiceTest {

    @Test
    public void testCellValAsString() {
        Assert.assertEquals("123", ExcelAbstractHandler.cellValAsString("123"));
        Assert.assertNull(ExcelAbstractHandler.cellValAsString(null));
        double d = 12.360;
        Assert.assertEquals("12.36", ExcelAbstractHandler.cellValAsString(d));
        long e = 123456789456L;
        Assert.assertEquals("123456789456", ExcelAbstractHandler.cellValAsString(e));
        int f = 123;
        Assert.assertEquals("123", ExcelAbstractHandler.cellValAsString(f));
    }

    @Test
    public void testBigDecimal() {
//        BigDecimal num = new BigDecimal("1.2");
//        BigDecimal ret = num.multiply(BigDecimal.valueOf(134)).divide(BigDecimal.valueOf(6), 2, RoundingMode.HALF_UP);
//        BigDecimal ret2 = BigDecimal.valueOf(134).divide(BigDecimal.valueOf(6), 4, RoundingMode.HALF_UP).multiply(num).setScale(2, RoundingMode.HALF_UP);
    }

    @Test
    public void testAba() {
        StringBuilder sb = new StringBuilder();
        sb.append(" SELECT count(1) ");
        sb.append(" FROM ( ");
        sb.append("        SELECT a.* , SUM(k.`used_num`)  AS num ");
        sb.append("        FROM crm_employe_fitting a ");
        sb.append("        LEFT JOIN `crm_site_fitting_used_record`  k ");
        sb.append("        ON k.`fitting_id` = a.`fitting_id` AND k.`site_id` = a.`site_id` AND k.`employe_id` = a.`employe_id` and k.`status` in ('1', '3') ");
        sb.append(" WHERE a.`status` = 1 ");
        sb.append(" GROUP BY a.`id` HAVING a.`number`  <> num  or (a.`number` <> 0 and num IS NULL  ) ");
        sb.append(" ) oa ");
        sb.append("  ");
    }
}
