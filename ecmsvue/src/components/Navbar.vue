<template>
  <el-header>
    <div class="navbar">
      <el-menu
          :default-active="activeIndex"
          class="menu"
          @select="handleSelect"
          mode="horizontal"
      >
        <el-menu-item index="home">首页</el-menu-item>
        <el-menu-item index="products">产品管理</el-menu-item>
        <el-menu-item index="orders">订单管理</el-menu-item>

        <!-- 登出按钮放最右边 -->
        <div class="logout-wrapper">
          <el-menu-item index="logout" @click="handleLogout">登出</el-menu-item>
        </div>
      </el-menu>
    </div>
  </el-header>
</template>

<script>
export default {
  name: 'AppNavbar',
  data() {
    return {
      activeIndex: 'home'
    };
  },
  methods: {
    handleSelect(index) {
      if (index === 'logout') return; // 防止重复执行登出逻辑
      this.activeIndex = index;
      this.$router.push({ name: index });
    },
    handleLogout() {
      localStorage.removeItem('token');
      this.$router.push('/login');
    }
  }
};
</script>

<style scoped>
.navbar {
  background-color: #409eff;
  color: #ffffff;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.menu {
  line-height: 60px;
  width: 100%;
}

.logout-wrapper {
  margin-left: auto;
}
</style>
