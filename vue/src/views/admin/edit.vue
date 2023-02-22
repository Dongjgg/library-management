<template>
    <div style="width: 80%">
        <div style="margin-bottom: 30px">编辑管理员</div>
        <el-form :inline="true" :model="form" :rules="rules" ref="ruleForm" label-width="100px">
            <el-form-item label="用户名" prop="username">
                <el-input v-model="form.username" disabled placeholder="请输入用户名"></el-input>
            </el-form-item>
            <el-form-item label="手机号" prop="phone">
                <el-input v-model="form.phone" placeholder="请输入手机号"></el-input>
            </el-form-item>
            <el-form-item label="邮箱" prop="address">
                <el-input v-model="form.email" placeholder="请输入邮箱"></el-input>
            </el-form-item>
        </el-form>

        <div style="text-align: center; margin-top: 30px">
            <el-button type="primary" @click="save" size="medium">提交</el-button>
        </div>
    </div>
</template>

<script>
    import request from "@/utils/request";

    export default {
        name: 'AddAdmin',
        data() {
            const checkEmail = (rule, value, callback) => {
                if (!value) {
                    return callback(new Error('年龄不能为空'));
                }
                if (!/^[0-9]+$/.test(value)) {
                    callback(new Error('请输入数字值'));
                }
                if (parseInt(value) > 120 || parseInt(value) <= 0) {
                    callback(new Error('请输入合理的年龄'));
                }
                callback()
            };
            const checkPhone = (rule, value, callback) => {
                if (!/^[1][3,4,5,6,7,8,9][0-9]{9}$/.test(value)) {
                    callback(new Error('请输入合法的手机号'));
                }
                callback()
            };
            return {
                form: {sex: '男'},
                rules: {
                    username: [
                        { required: true, message: '请输入用户名', trigger: 'blur'}
                    ],
                    email: [
                        { validator: checkEmail, trigger: 'blur' }
                    ],
                    phone: [
                        { validator: checkPhone, trigger: 'blur' }
                    ]
                }
            }
        },
        created() {
            let id = this.$route.query.id;
            request.get('/admin/'+ id).then(res=>{
                this.form = res.data
            })
        },
        methods: {
            save(){
                this.$refs['ruleForm'].validate((valid) => {
                    console.log(valid)
                    if (valid) {
                        request.put('/admin/update',this.form).then(res=>{
                            if (res.code==='200'){
                                this.$notify.success('更新成功')
                                this.$router.push("/adminList")
                            }else {
                                this.$notify.error(res.msg)
                            }
                        })
                    }
                })
            }
        }
    }

</script>

