class HintBox extends HTMLElement {
  static get observedAttributes() {
    return ['title', 'message'];
  }

  constructor() {
    super();
    this.attachShadow({ mode: 'open' });
  }

  connectedCallback() {
    this.render();
  }

  attributeChangedCallback() {
    this.render();
  }

  render() {
    const title = this.getAttribute('title') ?? '';
    const message = this.getAttribute('message') ?? this.textContent.trim();

    this.shadowRoot.innerHTML = `
      <style>
        :host {
          display: block;
        }

        .hint-box {
          display: flex;
          flex-direction: row;
          justify-content: space-between;
          align-items: baseline;
          gap: 1rem;
          border-radius: var(--hint-box-radius, 0.75rem);
          border: var(--hint-box-border, 1px solid #d4d1ca);
          background: var(--hint-box-bg, #f9f8f5);
          color: var(--hint-box-color, #28251d);
          padding: var(--hint-box-padding, 1rem 1.25rem);
          font-family: var(--hint-box-font, sans-serif);
        }

        .hint-box__title {
          margin: 0;
          font-size: var(--hint-box-title-size, 1rem);
          font-weight: var(--hint-box-title-weight, 600);
          color: var(--hint-box-title-color, inherit);
          white-space: nowrap;   /* Titel bleibt einzeilig */
          flex-shrink: 0;        /* Titel wird nicht gequetscht */
        }

        .hint-box__message {
          margin: 0;
          font-size: var(--hint-box-message-size, 0.9rem);
          line-height: 1.5;
          color: var(--hint-box-message-color, inherit);
          text-align: left;     /* Text linksbündig */
          flex: 1;               /* Message füllt den restlichen Platz */
        }

        .hint-box__title:empty {
          display: none;
        }
      </style>

      <div class="hint-box" part="box">
        <p class="hint-box__title" part="title">${title}</p>
        <p class="hint-box__message" part="message">${message}</p>
      </div>
    `;
  }
}

customElements.define('hint-box', HintBox);
