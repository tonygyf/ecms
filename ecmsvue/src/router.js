import { createRouter, createWebHistory } from 'vue-router';
import ProductsPage from './views/Products.vue';
import OrdersPage from './views/Orders.vue';
import HomePage from '../src/views/Home.vue';

const routes = [
    {
        path: '/products',
        name: 'products',
        component: ProductsPage
    },
    {
        path: '/orders',
        name: 'orders',
        component: OrdersPage
    },
    {
        path: '/',
        name: 'HomePage',
        component: HomePage
    },

];

const router = createRouter({
    history: createWebHistory(),
    routes
});

export default router;
