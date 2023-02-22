package com.dj.mapper;

import com.dj.controller.request.BaseRequest;
import com.dj.pojo.Category;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface CategoryMapper {
    @Select("select * from category")
    List<Category> list();

    List<Category> listByCondition(BaseRequest baseRequest);

    void save(Category category);

    Category getById(Integer id);

    void updateById(Category category);

    void deleteById(Integer id);
}
