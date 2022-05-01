class TabButtonArea extends HTMLElement
{
    constructor(protocol)
    {
        super();

        this.id = protocol.title + '-' + protocol.patientType + '-' + protocol.certificationLevel + 'button-area';
        this.classList = ('tab-button-area');

        this.detailButton = document.createElement('button');
        this.detailButton.classList = ('detail-button card-button');
        this.detailButton.addEventListener('click', this.onDetailButtonPress);

        this.editButton = document.createElement('button');
        this.editButton.classList = ('edit-button card-button');
        this.editButton.addEventListener('click', this.onEditButtonPress);

        this.deleteButton = document.createElement('button');
        this.deleteButton.classList = ('delete-button card-button'); 
        this.deleteButton.addEventListener('click', this.onDeleteButtonPress);

        this.appendChild(this.detailButton);
        this.appendChild(this.editButton);
        this.appendChild(this.deleteButton); 
        
    }

    onDetailButtonPress()
    {
        // TODO:
        console.log("Detail button pressed. /n");
    }

    onEditButtonPress()
    {
        //TODO:
        console.log("Edit button pressed. /n");
    }

    onDeleteButtonPress()
    {
        //TODO:
        console.log("Delete button pressed. /n");
    }
} 

customElements.define('tab-button-area', TabButtonArea);

export { TabButtonArea };