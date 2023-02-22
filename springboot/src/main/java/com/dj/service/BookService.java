package com.dj.service;

import com.dj.controller.request.BaseRequest;
import com.dj.pojo.Book;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface BookService {
    
    List<Book> list();

    PageInfo<Book> page(BaseRequest baseRequest);

    void save(Book obj);

    Book getById(Integer id);

    void update(Book obj);

    void deleteById(Integer id);

}
