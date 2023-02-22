<template>
    <div>
        <!--搜索表单-->
        <div style="margin-bottom: 20px">
            <el-input style="width: 240px" placeholder="请输入分类名称" v-model="params.name"></el-input>
            <el-button style="margin-left: 5px;" class="el-button--primary" @click="load()"><i class="el-icon-search"></i>搜索</el-button>
            <el-button style="margin-left: 5px;" class="el-button--warning" @click="reset()"><i class="el-icon-refresh"></i>重置</el-button>
        </div>

        <el-table :data="tableData" stripe row-key="id" default-expand-all>
            <el-table-column prop="id" label="编号"></el-table-column>
            <el-table-column prop="name" label="用户名"></el-table-column>
            <el-table-column prop="remark" label="备注"></el-table-column>
            <el-table-column prop="createtime" label="创建时间"></el-table-column>
            <el-table-column prop="updatetime" label="更新时间"></el-table-column>



            <el-table-column label="操作" width="300px">
                <template v-slot="scope" >
                    <!--scope.row，就是当前行的数据-->
                    <el-button v-if="!scope.row.pid" type="success" @click="handleAdd(scope.row)">添加二级分类</el-button>
                    <el-button type="primary" @click="$router.push('/editCategory?id=' + scope.row.id)">编辑</el-button>

                    <template>
                        <el-popconfirm
                                style="margin-left: 5px"
                                confirm-button-text='确定'
                                cancel-button-text='取消'
                                icon="el-icon-info"
                                icon-color="red"
                                title="您确定删除这条数据吗？"
                                @confirm = "del(scope.row.id)"
                        >
                            <el-button type="danger" slot="reference">删除</el-button>
                        </el-popconfirm>
                    </template>

                   

                </template>
            </el-table-column>
        </el-table>

        <!--分页-->
        <div style="margin-top: 20px">
            <el-pagination
                    background
                    :current-page="params.pageNum"
                    :page-size="params.pageSize"
                    layout="prev, pager, next"
                    @current-change="handleCurrentChange"
                    :total="total">
            </el-pagination>
        </div>

    <div>
    <el-dialog title="添加二级分类" :visible.sync="dialogFormVisible" width="30%">
        <el-form :model="form" label-width="100px" ref="ruleForm" :rules="rules" style="width:85%">
            <el-form-item label="分类名称" prop="name">
                <el-input v-model="form.name" autocomplete="off"></el-input>
            </el-form-item>
            <el-form-item label="备注" prop="remark">
                <el-input v-model="form.remark" autocomplete="off"></el-input>
            </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
            <el-button @click="dialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="save">确 定</el-button>
        </div>
    </el-dialog>
    </div>

    </div>
</template>

<script>
    import request from "@/utils/request";
    import Cookies from 'js-cookie'

    export default {
        name: 'CategoryList',
        data() {
            return {
                dialogFormVisible: false,
                form: {},
                pid: null,
                category: Cookies.get('category')?JSON.parse(Cookies.get('category')):{},
                tableData: [],
                total: 0,
                params: {
                    pageNum: 1,
                    pageSize: 10,
                    name: '',
                    remark: ''
                },
                rules: {
                    name: [
                        { required: true, message: '请输入分类的名称', trigger: 'blur'}
                    ]
                }
            }
        },
        created() { //页面初始化时调用
            this.load()
        },
        methods: {
            handleAdd(row){
                this.pid = row.id;  //将当前行的id作为二级分类的pid
                this.dialogFormVisible = true
            },
            save(){
                this.$refs['ruleForm'].validate((valid) => {
                    if (valid) {
                        //赋值pid给二级分类
                        this.form.pid = this.pid
                        request.post('/category/save',this.form).then(res=>{
                            if (res.code==='200'){
                                this.$notify.success('新增二级分类成功')
                                this.$refs['ruleForm'].resetFields();
                                this.dialogFormVisible = false
                                this.load()
                            }else {
                                this.$notify.error(res.msg)
                            }
                        })
                    }
                })
                // this.form={}
            },
            load(){
                // fetch('http://localhost:9090/user/list').then(res=>res.json()).then(res=>{
                //   console.log(res);
                //   this.tableData = res.data;
                // })
                request.get('/category/page',{
                    params: this.params
                }).then(res=>{
                    if (res.code==='200'){
                        this.tableData = res.data.list
                        this.total = res.data.total
                    }
                })
            },
            reset(){
                this.params = {
                    pageNum: 1,
                    pageSize: 10,
                    name: '',
                }
                this.load()
            },
            handleCurrentChange(pageNum){
                //点击分页按钮触发
                this.params.pageNum = pageNum
                this.load()
            },
            del(id){
                request.delete("/category/delete/"+id).then(res=>{
                    if (res.code === '200'){
                        this.$notify.success("删除成功")
                        this.load()
                    }else {
                        this.$notify.error(res.msg)
                    }
                })
            }
        }
    }
</script>
