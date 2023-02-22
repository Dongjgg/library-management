package com.dj.service;

import com.dj.controller.request.BaseRequest;
import com.dj.pojo.Borrow;
import com.dj.pojo.Retur;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface BorrowService {
    
    List<Borrow> list();

    PageInfo<Borrow> page(BaseRequest baseRequest);

    void save(Borrow obj);

    PageInfo<Retur> pageRetur(BaseRequest baseRequest);

    void saveRetur(Retur obj);

    Borrow getById(Integer id);

    void update(Borrow obj);

    void deleteById(Integer id);

    void deleteReturById(Integer id);

    Map<String, Object> getCountByTimeRange(String timeRange);
}
