<template>
<div class="card" v-if="loading">
    <ProgressBar mode="indeterminate" style="height: 16px"></ProgressBar>
</div>

<div v-else class="max-w-4xl flex items-center h-auto lg:h-screen flex-wrap mx-auto my-32 lg:my-0">
    
	<!--Main Col-->
	<div id="profile" class="w-full lg:w-3/5 rounded-lg lg:rounded-l-lg lg:rounded-r-none shadow-2xl bg-white opacity-75 mx-6 lg:mx-0">
	

		<div class="p-4 md:p-12 text-center lg:text-left">
			<!-- Image for mobile view-->
			<div class="block lg:hidden rounded-full shadow-xl mx-auto -mt-16 h-48 w-48 bg-cover bg-center" style="background-image: url('https://source.unsplash.com/MP0IUfwrn0A')"></div>
			
			<h1 class="text-3xl font-bold pt-8 lg:pt-0">{{ perfil.email }}</h1>
			<div class="mx-auto lg:mx-0 w-4/5 pt-3 border-b-2 border-green-500 opacity-25"></div>
			<p class="pt-4 text-base font-bold flex items-center justify-center lg:justify-start"><svg class="h-4 fill-current text-green-700 pr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M9 12H1v6a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-6h-8v2H9v-2zm0-1H0V5c0-1.1.9-2 2-2h4V2a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v1h4a2 2 0 0 1 2 2v6h-9V9H9v2zm3-8V2H8v1h4z"/></svg> {{ perfil.name}}</p>
			<p class="pt-2 text-gray-600 text-xs lg:text-sm flex items-center justify-center lg:justify-start"><svg class="h-4 fill-current text-green-700 pr-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M10 20a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm7.75-8a8.01 8.01 0 0 0 0-4h-3.82a28.81 28.81 0 0 1 0 4h3.82zm-.82 2h-3.22a14.44 14.44 0 0 1-.95 3.51A8.03 8.03 0 0 0 16.93 14zm-8.85-2h3.84a24.61 24.61 0 0 0 0-4H8.08a24.61 24.61 0 0 0 0 4zm.25 2c.41 2.4 1.13 4 1.67 4s1.26-1.6 1.67-4H8.33zm-6.08-2h3.82a28.81 28.81 0 0 1 0-4H2.25a8.01 8.01 0 0 0 0 4zm.82 2a8.03 8.03 0 0 0 4.17 3.51c-.42-.96-.74-2.16-.95-3.51H3.07zm13.86-8a8.03 8.03 0 0 0-4.17-3.51c.42.96.74 2.16.95 3.51h3.22zm-8.6 0h3.34c-.41-2.4-1.13-4-1.67-4S8.74 3.6 8.33 6zM3.07 6h3.22c.2-1.35.53-2.55.95-3.51A8.03 8.03 0 0 0 3.07 6z"/></svg> {{ moment(perfil.created_at).format('DD-MM-YYYY HH:mm') }}</p>
			
			<p class="pt-8 text-sm">Roles asignados</p>

			<div>
				<ul>
					<li v-for="role in perfil.roles" :key="role.id"> {{ role.name }} </li>
				</ul>
			</div>

			<p class="pt-8 text-sm">Rerfiles</p>

			<div>
				<ul>
					<li v-for="(permiso, pos) in perfil.permisos" :key="pos"> {{ permiso.name }} </li>
				</ul>
			</div>

			<div class="pt-12 pb-8">
				<button class="bg-green-700 hover:bg-green-900 text-white font-bold py-2 px-4 rounded-full"
                @click="funSalir()">
				  Cerrar Sesion (Salir)
				</button> 
			</div> 

		</div>

	</div>
	
	<!--Img Col-->
	<div class="w-full lg:w-2/5">
		<!-- Big profile image for side bar (desktop) -->
		<img src="https://source.unsplash.com/MP0IUfwrn0A" class="rounded-none lg:rounded-lg shadow-2xl hidden lg:block">
		<!-- Image from: http://unsplash.com/photos/MP0IUfwrn0A -->
		
	</div>
	
	
	<!-- Pin to top right corner -->
	  <div class="absolute top-0 right-0 h-12 w-18 p-4">
		<button class="js-change-theme focus:outline-none">🌙</button>
	  </div>

</div>

</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useRouter} from "vue-router";
import authService from '../../../services/auth.service';
import moment from 'moment';


    const perfil = ref({});
	const loading = ref(true);

    const router = useRouter()

    onMounted(() => {
        getPerfil()
    });

    async function getPerfil(){
		loading.value = true;
        const {data} = await authService.perfil();
        perfil.value = data;
		loading.value = false;
    }

    async function funSalir(){
        await authService.salir();

        localStorage.removeItem('access_token');

        router.push({name: "Login"})
    }

</script>