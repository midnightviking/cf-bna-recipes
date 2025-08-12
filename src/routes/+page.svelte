<script>
import './global.scss';	
	import Button,{Icon} from '@smui/button';
	import { mdiFoodForkDrink, mdiChefHat, mdiScale, mdiFoodApple, mdiPeanutOff } from '@mdi/js';
</script>
<Button href="/recipes" class="nav-link" title="Recipes">
<Icon tag="svg" viewBox="0 0 24 24"><path d={mdiFoodForkDrink} /></Icon>
Recipes
</Button>
<Button href="/cookbooks" class="nav-link" title="Menus/Cookbooks">
<Icon tag="svg" viewBox="0 0 24 24"><path d={mdiChefHat} /></Icon>
Menus
</Button>
<Button href="/units" class="nav-link" title="Units">
<Icon tag="svg" viewBox="0 0 24 24"><path d={mdiScale} /></Icon>
Units
</Button>
<Button href="/ingredients" class="nav-link" title="Ingredients">

<Icon tag="svg" viewBox="0 0 24 24"><path d={mdiFoodApple} /></Icon>
Ingredients
</Button>
<Button href="/extensions" class="nav-link" title="Extensions">
<Icon tag="svg" viewBox="0 0 24 24"><path d={mdiPeanutOff} /></Icon>
Extensions
</Button>
<hr>

