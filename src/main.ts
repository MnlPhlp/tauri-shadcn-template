import { createApp } from "vue";
import App from "./App.vue";
import "./assets/index.css";
import { createPinia } from "pinia";
import { createPlugin } from "tauri-plugin-pinia";

const pinia = createPinia();
pinia.use(createPlugin());

const app = createApp(App);
app.use(pinia)
app.mount("#app");
