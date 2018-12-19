import './index.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

const app = Main.embed(document.getElementById('root'), { language: window.localStorage.getItem('language') });

app.ports.storeLanguage.subscribe(language => window.localStorage.setItem('language', language));

registerServiceWorker();
