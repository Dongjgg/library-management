package com.dj.service;

import com.dj.controller.request.BaseRequest;
import com.dj.pojo.Category;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface CategoryService {
    List<Category> list();

    PageInfo<Category> page(BaseRequest baseRequest);

    void save(Category catrgory);

    Category getById(Integer id);

    void update(Category catrgory);

    void deleteById(Integer id);

}
