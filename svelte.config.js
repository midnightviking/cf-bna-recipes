import adapter from '@sveltejs/adapter-cloudflare';

const config = {
	kit: {
		adapter: adapter(), prerender: {
			crawl: false, // Disable the prerender crawler
			entries: []   // Ensure no routes are prerendered by default
		} } };

export default config;