<template>
    <div>
        <!--搜索表单-->
        <div style="margin-bottom: 20px">
            <el-input style="width: 240px" placeholder="请输入用户名" v-model="params.username"></el-input>
            <el-input style="width: 240px; margin-left: 5px;" placeholder="请输入手机号" v-model="params.phone"></el-input>
            <el-input style="width: 240px; margin-left: 5px;" placeholder="请输入邮箱" v-model="params.email"></el-input>
            <el-button style="margin-left: 5px;" class="el-button--primary" @click="load()"><i class="el-icon-search"></i>搜索</el-button>
            <el-button style="margin-left: 5px;" class="el-button--warning" @click="reset()"><i class="el-icon-refresh"></i>重置</el-button>
        </div>

        <el-table :data="tableData" stripe>
            <el-table-column prop="id" label="编号"></el-table-column>
            <el-table-column prop="username" label="用户名"></el-table-column>
            <el-table-column prop="phone" label="手机号"></el-table-column>
            <el-table-column prop="email" label="邮箱"></el-table-column>
            <el-table-column prop="createtime" label="创建时间"></el-table-column>
            <el-table-column prop="updatetime" label="更新时间"></el-table-column>
            <el-table-column label="状态">
                <template v-slot="scope">
                    <el-switch
                            v-model="scope.row.status"
                            @change="changeStatus(scope.row)"
                            active-color="#13ce66"
                            inactive-color="#ff4949">
                    </el-switch>
                </template>
            </el-table-column>


            <el-table-column label="操作" width="230px">
                <template v-slot="scope" >
                    <!--scope.row，就是当前行的数据-->
                    <el-button type="primary" @click="$router.push('/editAdmin?id=' + scope.row.id)">编辑</el-button>

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

                    <el-button style="margin-left: 5px" type="warning" @click="handleChangePass(scope.row)">修改密码</el-button>

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
        <el-dialog title="修改密码" :visible.sync="dialogFormVisible" width="30%">
            <el-form :model="form" label-width="100px" ref="formRef" :rules="rules">
                <el-form-item label="新密码" prop="newPass">
                    <el-input v-model="form.newPass" autocomplete="off" show-password></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="savePass">确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
    import request from "@/utils/request";
    import Cookies from 'js-cookie'

    export default {
        name: 'AdminList',
        data() {
            return {
                admin: Cookies.get('admin')?JSON.parse(Cookies.get('admin')):{},
                tableData: [],
                total: 0,
                form: {},
                dialogFormVisible: false,
                params: {
                    pageNum: 1,
                    pageSize: 10,
                    name: '',
                    phone: '',
                    email: ''
                },
                rules: {
                    newPass: [
                        { required: true, message: '请输入新密码', trigger: 'blur'},
                        {min:3, max: 10, message: '长度在3-10个字符', trigger: 'blur'}
                    ]
                }
            }
        },
        created() { //页面初始化时调用
            this.load()
        },
        methods: {
            changeStatus(row){
                if (row.id===this.admin.id && !row.status){
                    row.status = true
                    this.$notify.error('您的操作不合法')
                    return
                }
                request.put('/admin/update',row).then(res=>{
                    if (res.code==='200'){
                        this.$notify.success('操作成功')
                        this.load()
                    }else {
                        this.$notify.error(res.msg)
                    }
                })
            },
            handleChangePass(row){
                this.form = JSON.parse(JSON.stringify(row))
                this.dialogFormVisible = true;
            },
            savePass(){
                this.$refs['formRef'].validate((valid)=>{
                    if (valid){
                        request.put('/admin/password',this.form).then(res=>{
                            if (res.code==='200'){
                                this.$notify.success("修改成功")
                                if (this.form.id === this.admin.id){  //如果修改的id是当前的管理员id就需要重新登录
                                    Cookies.remove('admin')
                                    this.$router.push('/login')
                                }else {
                                    this.load()
                                    this.dialogFormVisible=false
                                }
                            }else {
                                this.$notify.error("修改失败")
                            }
                        })
                    }
                })
            },
            load(){
                // fetch('http://localhost:9090/user/list').then(res=>res.json()).then(res=>{
                //   console.log(res);
                //   this.tableData = res.data;
                // })
                request.get('/admin/page',{
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
                    phone: '',
                    email: ''
                }
                this.load()
            },
            handleCurrentChange(pageNum){
                //点击分页按钮触发
                this.params.pageNum = pageNum
                this.load()
            },
            del(id){
                request.delete("/admin/delete/"+id).then(res=>{
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
