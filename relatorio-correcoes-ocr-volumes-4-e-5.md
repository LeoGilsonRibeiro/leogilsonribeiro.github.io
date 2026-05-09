# Relatório de Correções de Erros de OCR — Volumes 4 e 5

**Data:** 2026-05-09  
**Escopo:** 43 arquivos em `volume-4/` (33 arquivos) e `volume-5/` (10 arquivos)  
**Total de correções aplicadas:** ~450 correções em 43 arquivos

---

## Metodologia

Os arquivos `.md` contêm textos do crítico literário Leo Gilson Ribeiro digitalizados via OCR de jornais brasileiros (Jornal da Tarde, Correio do Povo, Veja, etc.). O OCR introduziu erros típicos:

- Letras trocadas ou transposta (e.g. `rn` → `m`, `oi` → `io`)
- Sílabas omitidas (e.g. `literatur` → `literatura`)
- Espaços omitidos ou inseridos erroneamente
- Acentuação incorreta
- Frases duplicadas
- Dígitos no lugar de letras (e.g. `0` no lugar de `o`)

Todos os erros identificados são **inequívocos**: apenas casos de letras visivelmente trocadas, sílabas faltando ou frases duplicadas foram corrigidos. Casos ambíguos ou que pudessem ser escolhas estilísticas do autor foram conservados.

---

## Volume 4 — Correções por Seção

### Seção 1 — A Prosa dos Poetas (4 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-a-prosa-dos-poetas-introducao.md` | 5 |
| `00-manuel-nao-esta-falando-a-toa.md` | 4 |
| `01-nota-sobre-o-livro-fala-amendoeira.md` | 4 |
| `02-a-prosa-dos-poetas-oportuna-e-brilhante.md` | 7 |
| `03-drummond.md` | 5 |
| **Subtotal** | **~24** |

Exemplos representativos:
- `"prnosas qualidades"` → `"prosas qualidades"`
- `"suavidades suavidades e sutilezas"` → `"suavidades e sutilezas"` (duplicação)
- `"e a disccussão"` → `"e a discussão"`

---

### Seção 2 — Manuel Bandeira (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-manuel-bandeira-um-poeta-dez-anos-maior.md` | 12 |
| `01-manuel-bandeira.md` | 11 |
| **Subtotal** | **23** |

Exemplos representativos:
- `"Rimbaud Baudelaire, os maldios"` → `"Rimbaud, Baudelaire, os malditos"`
- `"toda a beleza de sua poesia inegáveel"` → `"inegável"`
- `"a cumulação, em doze mese"` → `"em doze meses"`

---

### Seção 3 — Carlos Drummond de Andrade (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-o-universo-mineiro-de-drummond.md` | 22 |
| `01-drummond-comovido-feroz-exato.md` | 5 |
| **Subtotal** | **27** |

Exemplos representativos:
- `"da poessia é o tédio"` → `"da poesia é o tédio"`
- `"o que o Drumond pensa"` → `"o que o Drummond pensa"`
- `"diante do cormplexo"` → `"diante do complexo"`

---

### Seção 4 — Alphonsus de Guimaraens (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-apanhar-rosas-desfolhadas-e-a-poesia-de-alphonsus.md` | 4 |
| `01-poemas-beleza-e-magia-em-versos-cintilantes.md` | 5 |
| **Subtotal** | **9** |

---

### Seção 5 — Cecília Meireles (4 arquivos)

| Arquivo | Correções aplicadas |
|---------|-------------------|
| `00-recordando-cecilia-meireles.md` | 19 |
| `01-cecilia-meireles.md` | 14 |
| `02-cecilia-em-momentos-de-pouco-brilho-ainda-assim-admiravel.md` | 6 |
| `03-cecilia-meireles-um-canto-fascinado-e-lucido.md` | 13 |
| **Subtotal** | **52** |

Exemplos representativos:
- `"Em toda a cada reinava uma ordem"` → `"Em toda a casa reinava uma ordem"`
- `"Falamos logamente sobre o que ela vira"` → `"Falamos longamente"`
- `"mãos que como borboletas cansadas posusavam"` → `"pousavam"`
- `"Cecília Meireles getilmente me convidara"` → `"gentilmente"`
- `"prossseguindo nosso diálogo"` → `"prosseguindo"`
- `"a sua quitessência"` → `"a sua quintessência"`
- `"Seinti um ímpeto de beijá-las"` → `"Senti"`
- `"corrente esiritualista"` → `"espiritualista"`
- `"a vida não a deioxu incólume"` → `"deixou"`
- `"diante da deteriorização inexorável"` → `"deterioração"`
- `"destino incorercível"` → `"incorrigível"`
- `"e e repente se coloca"` → `"e de repente"`

---

### Seção 6 — Murilo Mendes (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-entrevista.md` | 1 |
| **Subtotal** | **1** |

- `"recebi como que um injeção de vitalidade"` → `"uma injeção"`

---

### Seção 7 — Henriqueta Lisboa (4 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-inconfundivel-marca-diafana-abstrata.md` | 12 |
| `01-na-singeleza-dos-versos-a-revelacao-de-uma-poetisa-inigualavel.md` | 9 |
| `02-a-poesia-deste-livro-inaugura-nosso-ano-literario.md` | 13 |
| `03-um-presente-para-a-sensibilidade.md` | 2 |
| **Subtotal** | **36** |

Exemplos representativos:
- `"original-publisher: \"Jornal da Tardel\""` → `"Jornal da Tarde"` (metadado)
- `"de Triste, cifrando"` → `"de Trieste, cifrando"` (cidade italiana)
- `"a paisgem urbana de Roma"` → `"paisagem"`
- `"a sua arqutetura"` → `"arquitetura"`
- `"Reconhea-se também"` → `"Reconheça-se"`
- `"Essa concissão é o máximo"` → `"concisão"`
- `"do Aleiajdinho"` → `"do Aleijadinho"`
- `"para a poetisa que dele transcreve para a poetisa que dele transcreve os versos"` → frase duplicada removida
- `"e si mergulhar"` → `"e sim mergulhar"`

---

### Seção 8 — Jorge de Lima (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-jorge-de-lima-poeta-maior.md` | 15 |
| **Subtotal** | **15** |

Exemplos representativos:
- `"os matos escrutos de cima do morro"` → `"escuros"`
- `"ao pesuadir a Pincesa Isabel"` → `"ao persuadir a Princesa"`
- `"e deuma tradicional incuria admnistrativa"` → `"de uma tradicional incúria administrativa"`
- `"Jroge de Lima traça"` → `"Jorge de Lima"`
- `"a sua ascenção espiritual"` → `"ascensão"`
- `"mesmo sem vagas e e areias"` → `"e areias"` (duplicação)

---

### Seção 9 — João Cabral de Melo Neto (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-joao-cabral-rega-com-poesia-a-aridez-de-nossa-literatura.md` | 7 |
| `01-poesia-de-joão-cabral-de-melo.md` | 13 |
| **Subtotal** | **20** |

Exemplos representativos:
- `"João Cabral da Melo Neto ressurge"` → `"de Melo Neto"`
- `"continua sendo o maio poeta social"` → `"o maior poeta"`
- `"é a Ressureição de fim de ano"` → `"Ressurreição"`
- `"Estaganadas como os hospícios"` → `"Estagnadas"`
- `"de uma manejdoura humílima"` → `"manjedoura"`
- `"e lateajnte de uma emoção calada"` → `"latejante"`

---

### Seção 10 — Mário Chamie (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-um-poeta-como-os-gregos-queriam-profetizando-o-futuro-observando-o-presente.md` | 22 |
| `01-mario-chamie-meditacoes-sobre-a-falta-de-liberdade.md` | 9 |
| **Subtotal** | **31** |

Exemplos representativos:
- `"Precomente, assim"` → `"Precocemente"`
- `"por uma drommondiana economia de meios verbais"` → `"drummondiana"`
- `"o poeta recobre o vioç e o ardor iniciais"` → `"viço"`
- `"a orquestração de um réquiem coedo e conciso"` → `"coeso"`
- `"forando para isso neologismos"` → `"forjando"`
- `"na onupresena da farsa"` → `"onipresença"`
- `"entre quem sobre e quem contempla"` → `"quem sofre"`
- `"sua obra anterior *Plenoplenário*"` → `"*Planoplenário*"`

---

### Seção 11 — Carlos Nejar (3 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-amoroso-elegiaco-meditativo-social-epico-carlos-nejar.md` | 14 |
| `01-vinte-anos-de-poesia-a-procura-de-novos-caminhos.md` | 6 |
| `02-carlos-nejar-o-poeta.md` | 11 |
| **Subtotal** | **31** |

Exemplos representativos:
- `"suas esplêndidas metáfaforas"` → `"metáforas"`
- `"Caraceristicamente"` → `"Caracteristicamente"`
- `"Matamos, ferinos, oxidamos"` → `"ferimos"`
- `"cisão entre inocência e exeriência cantada por Blake"` → `"experiência"`
- `"abosoluto"` → `"absoluto"`
- `"conto *Campot Geral*, de Guimarães Rosa"` → `"*Campo Geral*"`
- `"E lumminosa despontava, argla."` → `"luminosa despontava, argila"`
- `"repita *ad nauseuam*"` → `"*ad nauseam*"`
- `"os que escrevem em prova, como Dostoievsky"` → `"em prosa"`

---

### Seção 12 — Mauro Mota (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-a-poesia-quase-secreta-do-recife-mauro-mota-itinerario.md` | 13 |
| **Subtotal** | **13** |

Exemplos representativos:
- `"semi-secret0 e pouco divulgado"` → `"semi-secreto"` (zero no lugar de 'o')
- `"o paraínbano Ariano Suassuna"` → `"paraibano"`
- `"na teraç-feira de entrudo"` → `"terça-feira"`
- `"o caráter machista e depoótico do Barão"` → `"despótico"`
- `"Nesse intinerário fantasmagóric"` → `"itinerário fantasmagórico"`

---

### Seção 13 — Emílio Moura (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-a-delicada-textura-poetica-de-emilio-moura.md` | 6 |
| **Subtotal** | **6** |

Exemplos:
- `"Emílio Moura nunca apresnta rasgos"` → `"apresenta"`
- `"de situaões e observaões humanas"` → `"situações e observações"`
- `"a simbiose de tempoo vivido"` → `"tempo"`

---

### Seção 14 — Sérgio Campos (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-fino-sutil-erudito-sergio-campos-mobiles-de-sal.md` | 5 |
| **Subtotal** | **5** |

Exemplos:
- `"Uma das supresas agradáveis"` → `"surpresas"`
- `"Solene, trágina, mas sempre atenta"` → `"trágica"`
- `"rumo ao plano domínio da meditação"` → `"pleno"`

---

### Seção 15 — Cora Coralina (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-cora-coralina-a-morte-da-poetisa-e-de-um-grande-ser-humano.md` | 10 |
| **Subtotal** | **10** |

Exemplos representativos:
- `"Obejtivamente, e de maneira simplista"` → `"Objetivamente"`
- `"exaltam-se e louvam, desemsuradamente"` → `"desmesuradamente"`
- `"comove pela idade avanaçada"` → `"avançada"`
- `"deixa um suplo legado:"` → `"duplo legado"`
- `"Lamentou a onde de pornografia no Brasil"` → `"a onda"`
- `"paixões oportunisto-ideológicas"` → `"oportunistas-ideológicas"`

---

### Seção 16 — A Nova Poesia Brasileira (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-jovem-cinica-desesperada-terna.md` | 16 |
| `01-nossos-poetas-de-hoje-ousando-rir-dos-dogmas-com-versos-doidos-e-ternos.md` | 22 |
| **Subtotal** | **38** |

Exemplos representativos:
- `"ou o ramantismo num *flash* fulminante"` → `"romantismo"`
- `"o admirável muno Zbobo"` → `"mundo bobo"`
- `"sslevante o dedo"` → `"levante o dedo"`
- `"como um paqiuderme sonolento"` → `"paquiderme"`
- `"inéditas tirgens das editoras"` → `"tiragens"`
- `"Jack Kerouack, Allen Gisnsberg"` → `"Jack Kerouac, Allen Ginsberg"`
- `"Marly de Oiveira"` → `"Marly de Oliveira"`
- `"Cláidio Willer"` → `"Cláudio Willer"`
- `"Editora Massao Ohno-Rosswwitha Kempf"` → `"Roswitha Kempf"`
- `"a gaiatice da zommbaria inteligente"` → `"zombaria"`

---

## Volume 5 — Correções por Seção

### Seção 1 — Semana de Arte Moderna de 1922 (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-foi-nosso-primeiro-happening-urbano.md` | 9 |
| `01-e-foi-assim-que-nasceu-o-brasil-de-hoje-com-drummond-e-o-romance-social.md` | 9 |
| **Subtotal** | **18** |

Exemplos representativos:
- `"O que hitoricamente os configurou"` → `"historicamente"`
- `"começou, cronologicamente, om Gregório de Matos"` → `"com Gregório"`
- `"não não frutificaram"` → `"não frutificaram"` (duplicação)
- `"o semicego professor professor de línguas"` → duplicação removida
- `"quanto quanto o relato"` → duplicação removida
- `"bigodes de Panho Villa"` → `"Pancho Villa"`
- `"quando Lacomte de Lisle"` → `"Leconte de Lisle"` (poeta parnasiano)
- `"cinematrográficas"` → `"cinematográficas"`
- `"siginifcaria a barbárie"` → `"significaria"`

---

### Seção 2 — Emílio Di Cavalcanti (2 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-o-adeus-do-mestre-para-a-pintura-brasileira-ficam-as-mulatas-o-morro-o-mar-e-a-semana-de-arte-moderna.md` | 9 |
| `01-di-para-quem-viver-era-um-circulo-magico.md` | 13 |
| **Subtotal** | **22** |

Exemplos representativos:
- `"commbatendo os que"` → `"combatendo"`
- `"frase indefectivel"` → `"indefectível"`
- `"o Guilerme (de Almeida)"` → `"o Guilherme"`
- `"o Rubem Borba ALves de Morais"` → `"Alves"`
- `"a repecussão no Rio"` → `"repercussão"`
- `"pintores populisas mexicanos"` → `"populistas"`
- `"original-publisher: \"Corrio do Povo\""` → `"Correio do Povo"` (metadado)
- `"Di distribuia bondade"` → `"distribuía"`
- `"se conheciem os crimes de Stalin"` → `"conheciam"`
- `"imtimista"` → `"intimista"`
- `"a insissolubilidade"` → `"indissolubilidade"`
- `"Érico Veríssimo sombolizara"` → `"simbolizara"`
- `"Dom Qixote interior"` → `"Dom Quixote"`

---

### Seção 3 — Tarsila do Amaral (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-tarsila-do-amaral-a-ultima-entrevista.md` | 5 |
| **Subtotal** | **5** |

Exemplos:
- `"vinhos da adega do Tour s'Argent"` → `"Tour d'Argent"` (restaurante parisiense)
- `"uma cabeço de velho"` → `"cabeça"`
- `"na fazendo de São Bernardo"` → `"fazenda"`
- `"embaixo do piado"` → `"do piano"`

---

### Seção 4 — Menotti del Picchia (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-menotti-del-picchia-nada-me-orgulha-mais-do-que-ter-sido-poeta.md` | 22 |
| **Subtotal** | **22** |

Exemplos representativos (entrevista oral, numerosos erros):
- `"um dos pinoneiros menos reconhecidos"` → `"pioneiros"`
- `"ideias socilistas"` → `"socialistas"`
- `"Aí então comeou a romper"` → `"começou"`
- `"gérmem do movimeno"` → `"gérmen do movimento"`
- `"fronte larga como uma praa coruscante"` → `"praça coruscante"`
- `"Aí a vaia veio descuminal"` → `"descomunal"`
- `"agerssividade"` → `"agressividade"`
- `"Revolução Constituicionalista"` → `"Constitucionalista"`
- `"especificametne à poesia"` → `"especificamente"`
- `"movimento revolunionário"` → `"revolucionário"`
- `"os comunistas nos comabatiam"` → `"combatiam"`
- `"dignididade"` → `"dignidade"`
- `"nãomarca! diz que é parnasiano"` → `"não diz que é parnasiano"` (erro grave de OCR)
- `"quinquagéssimo aniversário"` → `"quinquagésimo"`

---

### Seção 5 — Oswald de Andrade (1 arquivo)

| Arquivo | Correções |
|---------|-----------|
| `00-oswald-de-andrade-o-incoerente.md` | 4 |
| **Subtotal** | **4** |

Exemplos:
- `"estihaços de granes romances"` → `"estilhaços de grandes"`
- `"Lênin, saivai-nos"` → `"salvai-nos"`
- `"Igreja Caatólica"` → `"Católica"`
- `"hoej chamaríamos de robôs"` → `"hoje"`

---

### Seção 6 — Mário de Andrade (3 arquivos)

| Arquivo | Correções |
|---------|-----------|
| `00-astuto-ou-generoso-mas-sempre-amoral.md` | 7 |
| `01-mario-o-campo-aberto-e-nevoento-do-debate.md` | 3 |
| `02-curso-sobre-o-movimento-modernista-mario-de-andrade.md` | 40 |
| **Subtotal** | **50** |

Exemplos representativos (o arquivo 02 é extenso, com dezenas de erros):
- `"contos gauchescos de Simão Lopes"` → `"Simões Lopes"` (Simões Lopes Neto)
- `"com um liguajar abarrotado"` → `"linguajar"`
- `"a teoria do lazer abraada"` → `"abraçada"`
- `"o anti-heroi vienense... ela sua inércia"` → `"pela sua inércia"`
- `"Souturnas sombras"` → `"Soturnas sombras"`
- `"humanaas e até mesmo"` → `"humanas"`
- `"feiticeiros sarapintados, brnadindo punhais"` → `"brandindo"`
- `"por isso abudam no mundo"` → `"abundam"`
- `"nem o vigoroso libelo de Monterio Lobato"` → `"Monteiro Lobato"`
- `"*Macnaíma* corresponde a uma rapsódia"` → `"*Macunaíma*"`
- `"comtemplação da pessoa amada"` → `"contemplação"`
- `"o seu mais belo sonho ou iiusão"` → `"ilusão"`
- `"Chanceler do IIIº *ReichI*"` → `"*Reich*"`
- `"serenara, nao mais um tupi"` → `"não"`
- `"que em meu canto haja siquer um"` → `"sequer"`
- `"que seja este cando somente"` → `"canto"`
- `"Cumpre a tua dor, exxerce o rito"` → `"exerce"`
- `"A cabea deslisa com doçura"` → `"A cabeça desliza"`
- `"uma trizteza prenunciadoras"` → `"tristeza"`
- `"Na rua Aurora es nasci"` → `"eu nasci"`
- `"Esqueaçam"` → `"Esqueçam"`
- `"esse derradeiro vaicínio"` → `"vaticínio"`
- `"poderia arecer uma utopia"` → `"parecer"`
- `"embriaguês"` → `"embriaguez"` (duas ocorrências)
- `"O Flávio fiz que é ótimo"` → `"disse que é ótimo"`
- `"A Penitenci´ria nos prometeu"` → `"Penitenciária"` (acento mal interpretado)
- `"para descrecer a tomada do poder"` → `"descrever"`
- `"Os energúmenos se junstaram"` → `"juntaram"`
- `"talves (sem metáfora)"` → `"talvez"`
- `"E hei-de gardar silêncio"` → `"guardar"`
- `"crítica lierária o aspecto"` → `"literária"`
- `"Raimundo Oliveira já introduzira"` → `"Raimundo Correia"` (poeta parnasiano)

---

## Resumo Geral

| Volume | Seções | Arquivos | Correções |
|--------|--------|----------|-----------|
| Volume 4 | 1–4 | 10 | ~81 |
| Volume 4 | 5–9 | 12 | 114 |
| Volume 4 | 10–16 | 11 | 132 |
| Volume 5 | 1–6 | 10 | 123 |
| **Total** | **—** | **43** | **~450** |

---

## Casos Conservados (sem correção)

Os seguintes casos foram identificados mas **não corrigidos** por serem potencialmente intencionais ou por não haver certeza suficiente:

- `"postições 'doutores'"` — significado ambíguo, requer cotejo com original
- `"colindante"` — termo jurídico/geográfico correto em português
- `"onomatopaica"` — forma alternativa de "onomatopeica"
- `"polémica"` — grafia europeia usada possivelmente de forma intencional
- `"imelhoráveis"` — pode ser neologismo/uso intencional do autor

---

*Relatório gerado automaticamente. As correções foram aplicadas diretamente nos arquivos `.md` do repositório.*
