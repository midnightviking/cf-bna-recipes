<script>
	import "../global.scss";
    import "./form.scss";
	import TopAppBar, { Row, Section, Title, AutoAdjust } from "@smui/top-app-bar";
	import Drawer, { AppContent, Content, Header, Subtitle } from "@smui/drawer";
	import List, { Item, Text } from "@smui/list";
    import IconButton,{Icon} from "@smui/icon-button";
    import Button from "@smui/button";
    
	import { mdiBookOpenPageVariant, mdiChefHat, mdiScale, mdiFoodApple, mdiMenu } from '@mdi/js';
	
    let { children } = $props();


    let isOpen= $state(false);
    let topAppBar = $state(null);

</script>

<div class="recipe-layout">
    <TopAppBar bind:this={topAppBar} variant="fixed" collapsed={isOpen?true:false} >
        <Row>
          <Section>
            <IconButton class="material-icons" onclick={()=>{isOpen = !isOpen}}>
                <Icon tag="svg" viewBox="0 0 24 24"><path d={mdiMenu} /></Icon>
            </IconButton>
            <Title>Menu App</Title>
          </Section>
          <Section align="end" toolbar={true}>
           
              <Button href="/recipes" class="nav-link" title="Recipes">
                <Icon tag="svg" viewBox="0 0 24 24"><path d={mdiBookOpenPageVariant} /></Icon>
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
            
          </Section>
        </Row>
      </TopAppBar>
	
    <AutoAdjust {topAppBar} >
        <AppContent class="app-content">
            <main class="main-content">
                {@render children?.()}
            </main>
        </AppContent>
    </AutoAdjust>
</div>
