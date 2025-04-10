<template>
  <div>
    <AppNavbar />
    <h1>欢迎来到首页!</h1>
  </div>
</template>

<script>
import AppNavbar from '../components/Navbar.vue'; // 确保路径正确

export default {
  name: 'HomePage',
  components: {
    AppNavbar
  }
};
</script>
