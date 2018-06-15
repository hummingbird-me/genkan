import { h, render, Component } from 'preact';

export default function Authorization ({ auth: { scopes, user, client } }) {
  return (
    <div>
      <header>
        Authorize {client.name}
      </header>
    </div>
  );
}
