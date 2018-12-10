package com.jojowonet.modules.sys.service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import ivan.common.service.BaseService;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2017/10/24.
 */

@Component
@Transactional(readOnly = true)
public class CityService extends BaseService {
    public static Object  getPCD() {
        List<Record> ps = Db.find("select * from s_province");
        List<Record> cs = Db.find("select * from s_city");
        List<Record> ds = Db.find("select * from s_district");
        HashMap<String, List<Record>> csm = new HashMap<>();
        HashMap<String, List<Record>> dsm = new HashMap<>();
        for (Record c : cs) {
            String pid = String.valueOf(c.getLong("ProvinceId"));
            List<Record> records = csm.get(pid);
            if (records == null) {
                records = new ArrayList<>();
                csm.put(pid, records);
            }
            records.add(c);
        }
        for (Record d : ds) {
            String cid = String.valueOf(d.getLong("CityId"));
            List<Record> records = dsm.get(cid);
            if (records == null) {
                records = new ArrayList<>();
                dsm.put(cid, records);
            }
            records.add(d);
        }

        List<P> pList = new ArrayList<>();
        for (Record r : ps) {
            P p = new P();
            p.p = r.getStr("ProvinceName");
            pList.add(p);
            List<Record> cityRecords = csm.get(String.valueOf(r.getLong("ProvinceID")));
            p.c = new ArrayList<>();
            for (Record cr : cityRecords) {
                C c = new C();
                c.n = cr.getStr("CityName");
                c.a = new ArrayList<>();
                p.c.add(c);
                List<Record> districtRecords = dsm.get(String.valueOf(cr.getLong("CityID")));
                for (Record dr : districtRecords) {
                    D d = new D();
                    d.s = dr.getStr("DistrictName");
                    c.a.add(d);
                }
            }
        }
        HashMap<String, Object> ret = new HashMap<>();
        ret.put("citylist", pList);
        return ret;
    }
    
    public static List<Record> getProvince(){
    	List<Record> rds = Db.find(" select * from s_province a ");
    	return rds;
    }
    

    static class P {
        public String p;
        public List<C> c;

        public String getP() {
            return p;
        }

        public void setP(String p) {
            this.p = p;
        }

        public List<C> getC() {
            return c;
        }

        public void setC(List<C> c) {
            this.c = c;
        }
    }

    static class C {
        public String n;
        public List<D> a;

        public String getN() {
            return n;
        }

        public void setN(String n) {
            this.n = n;
        }

        public List<D> getA() {
            return a;
        }

        public void setA(List<D> a) {
            this.a = a;
        }
    }

    static class D {
        public String s;

        public String getS() {
            return s;
        }

        public void setS(String s) {
            this.s = s;
        }
    }


}
