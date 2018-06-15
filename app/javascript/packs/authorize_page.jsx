// Run this example by adding <%= javascript_pack_tag 'hello_typescript' %> to the head of your layout file,
// like app/views/layouts/application.html.erb.

import Authorization from '../components/authorization';
import { h, render } from 'preact';

document.addEventListener('DOMContentLoaded', () => {
  const auth = {
    client: { name: 'Test' },
    user: { name: 'Nuck', avatarUrl: '' },
    scopes: []
  };

  render(
    <Authorization auth={auth}/>,
    document.body
  )
})
