﻿
import {
    TitleBar
} from './titleBar.js';

import {
    TabArea
} from './tabArea.js';

class ProtocolCard extends HTMLElement {

    constructor(title, patientType)
    {

        super();

        this.id = title + '-' + patientType + '-protocolCard';
        this.classList = ('protocol-card');

        this.titleBar = new TitleBar(title, patientType);
        this.tabArea = new TabArea(title, patientType);

        this.appendChild(this.titleBar);
        this.appendChild(this.TabArea);
    }

    addTab(protocol)
    {
        this.tabArea.addTab(protocol.id, protocol.certificationLevel);
    }
}


customElements.define('protocol-card', ProtocolCard);

export { ProtocolCard };