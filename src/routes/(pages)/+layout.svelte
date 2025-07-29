
<script>
import "../global.scss";
import "./form.scss";
import TopAppBar, { Row, Section, Title, AutoAdjust } from "@smui/top-app-bar";
import Drawer, { AppContent, Content, Header, Subtitle } from "@smui/drawer";
import List, { Item, Text } from "@smui/list";
import IconButton,{Icon} from "@smui/icon-button";
import Button from "@smui/button";
import { setContext } from 'svelte';
import { mdiBookOpenPageVariant, mdiChefHat, mdiScale, mdiFoodApple, mdiMenu, mdiPeanutOff, mdiFoodForkDrink } from '@mdi/js';
import ActionBanner from "$lib/components/ActionBanner.svelte";
import { setActionBannerState } from "$lib/action-banner-state.svelte";
let { children } = $props();
let isOpen= $state(false);
let topAppBar = $state(null);

setActionBannerState();


</script>

<div class="recipe-layout">
    <TopAppBar bind:this={topAppBar} variant="fixed"  >
        <Row>
          <Section>
            <IconButton class="material-icons" onclick={()=>{isOpen = !isOpen}}>
                <Icon tag="svg" viewBox="0 0 24 24"><path d={mdiMenu} /></Icon>
            </IconButton>
            <Title>Menu App</Title>
          </Section>
          <Section align="end" toolbar={true}>
           
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
            
          </Section>
        </Row>
      </TopAppBar>
  
    <AutoAdjust {topAppBar} >
        <AppContent class="app-content">
            <ActionBanner/>
            <main class="main-content">
                {@render children?.()}
            </main>
        </AppContent>
    </AutoAdjust>
</div>
