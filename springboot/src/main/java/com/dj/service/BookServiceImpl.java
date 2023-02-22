package com.dj.service;

import cn.hutool.core.collection.CollUtil;
import com.dj.controller.request.BaseRequest;
import com.dj.pojo.Book;
import com.dj.exception.ServiceException;
import com.dj.mapper.BookMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@Service
@Slf4j
public class BookServiceImpl implements BookService {

    @Resource
    BookMapper bookMapper;


    @Override
    public List<Book> list() {
        return bookMapper.list();
    }

    @Override
    public PageInfo<Book> page(BaseRequest baseRequest) {
        PageHelper.startPage(baseRequest.getPageNum(), baseRequest.getPageSize());
        return new PageInfo<>(bookMapper.listByCondition(baseRequest));
    }

    @Override
    public void save(Book obj) {
        try{
            List<String> categories = obj.getCategories();
            obj.setCategory(category(obj.getCategories()));
            bookMapper.save(obj);
        }catch (Exception e){
            log.error("数据插入错误",e);
            throw new ServiceException("数据插入错误");
        }
    }

    @Override
    public Book getById(Integer id) {
        return bookMapper.getById(id);
    }

    @Override
    public void update(Book obj) {
        try{
            obj.setUpdatetime(LocalDate.now());
            obj.setCategory(category(obj.getCategories()));
            bookMapper.updateById(obj);
        }catch (Exception e){
            log.error("数据更新异常",e);
            throw new ServiceException("数据更新异常");
        }

    }

    @Override
    public void deleteById(Integer id) {
        bookMapper.deleteById(id);
    }

    private String category(List<String> categories) {
        StringBuilder sb = new StringBuilder();
        if (CollUtil.isNotEmpty(categories)) {
            categories.forEach(v -> sb.append(v).append(" > "));
            return sb.substring(0, sb.lastIndexOf(" > "));
        }
        return sb.toString();
    }

}
