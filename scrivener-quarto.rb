def string_to_path(str)
  str.unicode_normalize(:nfc)
     .tr("áéíóúàèìòùâêîôûäëïöüãõ",
         "aeiouaeiouaeiouaeiouao")
     .gsub(/\p{Mn}/, '')                         # Remover acentos (normalizar decompondo e remover non-spacing marks)
     .gsub(/[?*#:|"'<>,\\]*/, '')             # Remover caracteres proibidos em nomes de arquivos
     .gsub(/^(\X{1,70}\b)/, '\1')                # Limitar tamanho do nome de arquivo a aprox. 70 caracteres
#      .gsub(/ /, '-')
     .gsub(/-+/, '-')
     .downcase
     .unicode_normalize(:nfc)
end


str = <<~STR
          - section: "Literatura Brasileira"
            contents:
              - Volume-1/2 Literatura Brasileira/00-O-Negro-Na-Literatura-Brasileira.md
              - Volume-1/2 Literatura Brasileira/01-Entrevista-Leon-Damas-e-a-Negritude-Brasileira.md
              - Volume-1/2 Literatura Brasileira/02-Invencoes-e-Algemas-De-Castro-Alves.md
              - Volume-1/2 Literatura Brasileira/03-O-Mulato-Raimundo-Faz-Cem-Anos.md
              - Volume-1/2 Literatura Brasileira/04-Resenha-De-Lgr-Vetada-e-Nao-Publicada-No-Jt-Sobre-Adolfo-Caminha.md
              - Volume-1/2 Literatura Brasileira/05-A-Revolta-De-Um-Precursor.md
              - Volume-1/2 Literatura Brasileira/06-Lima-Barreto-Altamente-Inovador-e-Quase-Desconhecido.md
              - Volume-1/2 Literatura Brasileira/07-Lima-Barreto-Doce-Feroz-Iluminado-e-Esquecido.md
              - Volume-1/2 Literatura Brasileira/08-Policarpo-Quaresma-Uma-Obra-Prima-Envolta-Em-Doce-Amargura.md
              - Volume-1/2 Literatura Brasileira/09-A-Mae-Coragem-Negra-De-Caninde-Sobre-Os-Diarios-De-Carolina-Maria-De-Jesus.md
              - Volume-1/2 Literatura Brasileira/10-O-Negro-Nos-Livros-Poemas-e-Teses.md
              - Volume-1/2 Literatura Brasileira/11-Poesia-Uma-Obra-Reunindo-Poetas-Negros-De-Varias-Epocas.md
              - Volume-1/2 Literatura Brasileira/12-Nossa-Poesia-Negra-Tentando-Falar-Alemao.md
              - Volume-1/2 Literatura Brasileira/13-O-Evangelho-Da-Solidao-De-Eduardo-De-Oliveira.md
              - Volume-1/2 Literatura Brasileira/14-Prefacio-Ao-Livro-De-Paulo-Colina.md
              - Volume-1/2 Literatura Brasileira/15-Paulo-Colina-o-Poeta-Das-Cinzas.md
          - section: "Literatura Norte-Americana"
            contents:
              - Volume-1/3 Literatura Norte-Americana/00-Literatura-Negra-Nos-Estados-Unidos-James-Baldwin.md
              - Volume-1/3 Literatura Norte-Americana/01-James-Baldwin-e-o-Negro-Nos-Eua.md
              - Volume-1/3 Literatura Norte-Americana/02-o-Negro-Baldwin-Luta-Pelos-Seus.md
              - Volume-1/3 Literatura Norte-Americana/03-James-Baldwin-(Necrologio).md
              - Volume-1/3 Literatura Norte-Americana/04-Resenha-Do-Livro-o-Mensageiro-de-Charles-Wright-(Editora-Nova-Critica-1969).md
              - Volume-1/3 Literatura Norte-Americana/05-A-Influência-Decisiva-de-Richard-Wright.md
              - Volume-1/3 Literatura Norte-Americana/06-Entrevista-Toni-Morrison-e-Os-Negros-Da-America.md
              - Volume-1/3 Literatura Norte-Americana/07-Nota-Sobre-o-Livro-o-Olho-Mais-Azul-de-Toni-Morrison.md
          - section: "Literatura Africana"
            contents:
              - Volume-1/4 Literatura Africana/00-A-Africa-Em-Lendas-e-Contos-Lembrando-Nossa-Historia.md
              - Volume-1/4 Literatura Africana/01-A-Negritude-Transfiguracao-Poetica-Do-Rosto-Africano.md
              - Volume-1/4 Literatura Africana/02-Angola-Escreve-Uma-Arte-Magica-e-Sofrida-Vinda-de-Onde-Nao-Se-Sabe.md
              - Volume-1/4 Literatura Africana/03-Angola-Escreve-Alguns-Grandes-Autores-Do-Romance-Ao-Conto.md
              - Volume-1/4 Literatura Africana/04-A-Africa-e-a-Liberdade-Entrevista-Com-Luandino-Vieira.md
              - Volume-1/4 Literatura Africana/05-Angola-Num-Momento-de-Reflexoes-e-Mudancas-Entrevista-Com-o-Escritor-Angolano-Agostinho-Mendes.md
              - Volume-1/4 Literatura Africana/06-A-Ultima-Denuncia-de-Soromenho.md
              - Volume-1/4 Literatura Africana/07-Senghor-o-Orfeu-Negro.md
              - Volume-1/4 Literatura Africana/08-Resenha-Sobre-Poemas-de-Senghor.md
              - Volume-1/4 Literatura Africana/09-a-Poesia-Nao-Deve-Morrer-Senao-Que-Esperanca-Restaria-Ao-Mundo.md
              - Volume-1/4 Literatura Africana/10-Sebene-Ousmane-Do-Senegal-Um-Importante-Momento-Da-Literatura-Africana-Mas-a-Traducao.md
              - Volume-1/4 Literatura Africana/11-a-Africa-Hoje-Em-Dois-Bons-Livros-Lgr-Comenta-As-Obras-de-Chinua-Achebe-e-Cyprian-Ekwensi.md
              - Volume-1/4 Literatura Africana/12-o-Negro-e-a-Cultura-de-Mocambique-Nao-Merecem-Romance-Tao-Ruim-Quanto-Este.md
              - Volume-1/4 Literatura Africana/13-Resenha-Do-Livro-Um-Fuzil-Na-Mao-Um-Poema-No-Bolso-de-Emmanuel-Dongala.md
              - Volume-1/4 Literatura Africana/14-Um-Nobel-Para-a-Africa-Wole-Soyinka.md
              - Volume-1/4 Literatura Africana/15-Nota-Sobre-o-Livro-a-Arma-Da-Casa-de-Nadine-Gordimer.md
              - Volume-1/4 Literatura Africana/16-Nota-Sobre-o-Livro-Desonra-de-J-M-Coetzee.md
      - "---"
      - section: "2 Os escritores aquém e além da literatura: Guimarães Rosa, Clarice Lispector e Hilda Hils"
        href: Volume-2/index.qmd
        contents:
          - section: "Guimarães Rosa"
            contents:
              - Volume-2/1-Guimarães-Rosa/00-Guimaraes-Rosa-o-Sertao-o-Mundo-e-a-Travessia.md
              - Volume-2/1-Guimarães-Rosa/01-Breve-Roteiro-Da-Obra-de-Guimaraes-Rosa.md
              - Volume-2/1-Guimarães-Rosa/02-Um-Velho-Castelo-Macico-Uma-Nova-Flor-Poetica.md
              - Volume-2/1-Guimarães-Rosa/03-Guimaraes-Rosa.md
              - Volume-2/1-Guimarães-Rosa/04-Sobre-o-Conto-a-Hora-e-a-Vez-de-Augusto-Matraga.md
              - Volume-2/1-Guimarães-Rosa/05-Tutameia-Um-Atomo-Explode.md
              - Volume-2/1-Guimarães-Rosa/06-Orelha-Para-a-Primeira-Edicao-Do-Livro-Estas-Estorias-(1969).md
              - Volume-2/1-Guimarães-Rosa/07-Adeus-a-Palavra-(Nota-Sobre-Ave-Palavra-de-G-Rosa).md
              - Volume-2/1-Guimarães-Rosa/08-Guimaraes-Rosa-25-Anos-de-Veredas.md
              - Volume-2/1-Guimarães-Rosa/09-Vaqueiro-de-Roma.md
              - Volume-2/1-Guimarães-Rosa/10-Entrevista-Com-Edoardo-Bizzarri.md
              - Volume-2/1-Guimarães-Rosa/11-Guimaraes-Rosa-Novas-Luzes-Sobre-Um-Fascinante-Enigma.md
          - section: "Clarice Lispector"
            contents:
              - Volume-2/2-Clarice-Lispector/00-Tentativa-de-Explicacao.md
              - Volume-2/2-Clarice-Lispector/01-Que-Misterios-tem-Clarice-Lispector.md
              - Volume-2/2-Clarice-Lispector/02-Carta-de-Agradecimento-a-Clarice-por-um-Novo-Livro.md
              - Volume-2/2-Clarice-Lispector/03-Auto-Inspeccao.md
              - Volume-2/2-Clarice-Lispector/04-Muito-Sveglia.md
              - Volume-2/2-Clarice-Lispector/05-So-os-Mais-Atentos-Conseguem-Encontrar-esta-Maca-no-Escuro.md
              - Volume-2/2-Clarice-Lispector/06-A-Hora-das-Estrelas.md
              - Volume-2/2-Clarice-Lispector/07-Clarice-num-Derradeiro-Espelho-diante-de-si-mesma.md
              - Volume-2/2-Clarice-Lispector/08-Ineditos-de-Clarice-para-se-Conhecer-Melhor-Clarice.md
              - Volume-2/2-Clarice-Lispector/09-Clarice-uma-Mulher-que-Morreu-pela-Vontade-de-Escrever.md
              - Volume-2/2-Clarice-Lispector/10-Um-Reencontro-Fascinante-com-o-Universo-de-Clarice.md
              - Volume-2/2-Clarice-Lispector/11-Clarice-doando-um-Fragmento-Iluminado-de-si-Mesma-nestas-Cronicas.md
              - Volume-2/2-Clarice-Lispector/12-A-Silenciosa-Revolucao-de-Clarice.md
              - Volume-2/2-Clarice-Lispector/13-Evocacao-de-Clarice.md
          - section: "Hilda Hilst"
            contents:
              - Volume-2/3-Hilda-Hilst/00-Nota-Sobre-o-Livro-Poesia-1959-1967-(Livraria-Sal)-de-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/01-Esperando-Haydum.md
              - Volume-2/3-Hilda-Hilst/02-Poetisa-Em-Prosa-Qados-de-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/03-o-Vermelho-Da-Vida-Jubilo-Memoria-Noviciado-Da-Paixao-de-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/04-Hilda-Hilst-Em-Prosa-Ou-Poesia-a-Raridade-de-Uma-Obra-a-Frente-de-Seu-Tempo.md
              - Volume-2/3-Hilda-Hilst/05-Hilda-Hilst-Ficcoes-(Sao-Paulo-Edicoes-Quiron-Limitada-1977)-Pp-Vii-Xii.md
              - Volume-2/3-Hilda-Hilst/06-As-Multiplas-Seducoes-de-Hilda-Hilst-Entrevista.md
              - Volume-2/3-Hilda-Hilst/07-Depoimento-de-Hilda-Hilst-Eu-Quero-a-Juncao-Do-Misticismo-Com-a-Ciencia.md
              - Volume-2/3-Hilda-Hilst/08-a-Morte-Saudada-Em-Versos-Iluminados-Por-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/09-Quem-Tem-Medo-de-Hilda-Hist.md
              - Volume-2/3-Hilda-Hilst/10-Os-Versos-de-Hilda-Hilst-Integrando-a-Nossa-Realidade.md
              - Volume-2/3-Hilda-Hilst/11-Mais-Uma-Obra-de-Hilda-Hilst-Com-Todos-Os-Superlativos.md
              - Volume-2/3-Hilda-Hilst/12-Hilda-Encantamento-Mistico-Inigualavel.md
              - Volume-2/3-Hilda-Hilst/13-a-Esperanca-de-Chegar-Um-Dia-a-Ter-Esperanca-Hilda-Hilst-Esta-e-a-Literatura-Que-Eu-Escrevo.md
              - Volume-2/3-Hilda-Hilst/14-Hilda-Hilst-Cosmica-e-Atemporal-Em-Busca-de-Deus.md
              - Volume-2/3-Hilda-Hilst/15-Punhal-Destemido-Nota-Sobre-Com-Os-Meus-Olhos-de-Cao-de-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/16-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/17-a-Luminosa-Despedida-Seguida-de-Um-Longo-Depoimento-de-Hilda-Hilst.md
              - Volume-2/3-Hilda-Hilst/18-Da-Ficcao.md
      - "---"
      - section: "3 Testemunhos Literários do século XX"
        href: Volume-3/index.qmd
        contents:
          - text: "Revolução Estética da Arte Moderna"
            file: Volume-3/1-Revolução-Estética-Da-Arte-Moderna/index.qmd
          - section: "Charles Baudelaire"
            contents:
              - Volume-3/2-Charles-Baudelaire/00-Baudelaire-e-a-Revolucao-Da-Metafora-Poetica.md
              - Volume-3/2-Charles-Baudelaire/01-Baudelaire-Quase-Dois-Seculos-de-Uma-Poesia-Original-e-Sublime.md
              - Volume-3/2-Charles-Baudelaire/02-a-Traducao-de-As-Flores-Do-Mal-de-Baudelaire.md
          - section: "Federico García Lorca"
            contents:
              - Volume-3/3-Federico-García-Lorca/00-de-Sangue-de-Amor-e-Morte-Falou-Lorca.md
              - Volume-3/3-Federico-García-Lorca/01-Garcia-Lorca-e-o-Romancero-Gitano.md
              - Volume-3/3-Federico-García-Lorca/02-Tragica-Melancolia-(Nota-Sobre-a-Biografia-de-Ian-Gibson).md
          - section: "Franz Kafka"
            contents:
              - Volume-3/4-Franz-Kafka/00-Kafka-(Curso).md
              - Volume-3/4-Franz-Kafka/01-As-Cartas-a-Milena-Como-Documento-Literario-e-Da-Angustia-de-Kafka.md
              - Volume-3/4-Franz-Kafka/02-Kafka-Revive-Em-Praga.md
              - Volume-3/4-Franz-Kafka/03-Kafka-Em-Praga.md
              - Volume-3/4-Franz-Kafka/04-Kafka-(1983).md
          - section: "Jean Genet"
            contents:
              - Volume-3/5-Jean-Genet/00-a-Assuncao-Do-Martirio.md
              - Volume-3/5-Jean-Genet/01-a-Vespera-Do-Livro-Nossa-Senhora-Das-Flores.md
          - section: "Henry James"
            contents:
              - Volume-3/6-Henry-James/00-a-Musa-Tragica.md
              - Volume-3/6-Henry-James/01-a-Redescoberta-de-Henry-James-I.md
              - Volume-3/6-Henry-James/02-a-Redescoberta-de-Henry-James-Ii.md
              - Volume-3/6-Henry-James/03-a-Tragedia-e-a-Vitoria-de-Henry-James.md
          - section: "Guimarães Rosa"
            contents:
              - Volume-3/7-Guimarães-Rosa/00-Miguilim-e-o-Conhecimento-Da-Dor.md
      - "---"
      - section: "4 Poetas brasileiros contemporâneos"
        href: Volume-4/index.qmd
        contents:
          - section: "A Prosa dos Poetas"
            contents:
              - Volume-4/1-A-Prosa-dos-Poetas/00-Manuel-Nao-Esta-Falando-a-Toa.md
              - Volume-4/1-A-Prosa-dos-Poetas/01-Nota-Sobre-o-Livro-Fala-Amendoeira.md
              - Volume-4/1-A-Prosa-dos-Poetas/02-a-Prosa-Dos-Poetas-Oportuna-e-Brilhante.md
              - Volume-4/1-A-Prosa-dos-Poetas/03-Drummond.md
          - section: "Manuel Bandeira"
            contents:
              - Volume-4/2-Manuel-Bandeira/00-Manuel-Bandeira-Um-Poeta-Dez-Anos-Maior.md
              - Volume-4/2-Manuel-Bandeira/01-Manuel-Bandeira.md
          - section: "Carlos Drummond de Andrade"
            contents:
              - Volume-4/3-Carlos-Drummond-de-Andrade/00-o-Universo-Mineiro-de-Drummond.md
              - Volume-4/3-Carlos-Drummond-de-Andrade/01-Drummond-Comovido-Feroz-Exato.md
          - section: "Alphonsus de Guimaraens e Alphonsus de Guimaraens Filho"
            contents:
              - Volume-4/4-Alphonsus-de-Guimarãens-e-Alphonsus-de-Guimarãens-Filho/00-Lirios-Luar-Rosas-Desfolhadas-e-a-Poesia-de-Alphonsus.md
              - Volume-4/4-Alphonsus-de-Guimarãens-e-Alphonsus-de-Guimarãens-Filho/01-Poemas-Beleza-e-Magia-Em-Versos-Cintilantes.md
          - section: "Cecília Meireles"
            contents:
              - Volume-4/5-Cecília-Meireles/00-Recordando-Cecilia-Meireles.md
              - Volume-4/5-Cecília-Meireles/01-Cecilia-Meireles.md
              - Volume-4/5-Cecília-Meireles/02-Cecilia-Em-Momentos-de-Pouco-Brilho-Ainda-Assim-Admiravel.md
              - Volume-4/5-Cecília-Meireles/03-Cecilia-Meireles-Um-Canto-Fascinado-e-Lucido.md
          - section: "Murilo Mendes"
            contents:
              - Volume-4/6-Murilo-Mendes/00-Entrevista.md
          - section: "Henriqueta Lisboa"
            contents:
              - Volume-4/7-Henriqueta-Lisboa/00-Inconfundivel-Marca-Diafana-Abstrata.md
              - Volume-4/7-Henriqueta-Lisboa/01-Na-Singeleza-Dos-Versos-a-Revelacao-de-Uma-Poetisa-Inigualavel.md
              - Volume-4/7-Henriqueta-Lisboa/02-a-Poesia-Deste-Livro-Inaugura-Nosso-Ano-Literario.md
              - Volume-4/7-Henriqueta-Lisboa/03-Um-Presente-Para-a-Sensibilidade.md
          - section: "Jorge de Lima"
            contents:
              - Volume-4/8-Jorge-de-Lima/00-Jorge-de-Lima-Poeta-Maior.md
          - section: "João Cabral de Melo Neto"
            contents:
              - Volume-4/9-João-Cabral-de-Melo-Neto/00-Joao-Cabral-Rega-Com-Poesia-a-Aridez-de-Nossa-Literatura.md
          - section: "Mário Chamie"
            contents:
              - Volume-4/10-Mario-Chamie/00-Um-Poeta-Como-Os-Gregos-Queriam-Profetizando-o-Futuro-Observando-o-Presente.md
              - Volume-4/10-Mario-Chamie/01-Mario-Chamie-Meditacoes-Sobre-a-Falta-de-Liberdade.md
          - section: "Carlos Nejar"
            contents:
              - Volume-4/11-Carlos-Nejar/00-Amoroso-Elegiaco-Meditativo-Social-Epico-Carlos-Nejar.md
              - Volume-4/11-Carlos-Nejar/01-Vinte-Anos-de-Poesia-a-Procura-de-Novos-Caminhos.md
              - Volume-4/11-Carlos-Nejar/02-Carlos-Nejar-o-Poeta.md
          - section: "Mauro Mota"
            contents:
              - Volume-4/12-Mauro-Mota/00-a-Poesia-Quase-Secreta-Do-Recife-Mauro-Mota-Itinerario.md
          - section: "Emílio Moura"
            contents:
              - Volume-4/13-Emílio-Moura/00-a-Delicada-Textura-Poetica-de-Emilio-Moura.md
          - section: "Sérgio Campos"
            contents:
              - Volume-4/14-Sérgio-Campos/00-Fino-Sutil-Erudito-Sergio-Campos-Mobiles-de-Sal.md
          - section: "Cora Coralina"
            contents:
              - Volume-4/15-Cora-Coralina/00-Cora-Coralina-a-Morte-Da-Poetisa-e-de-Um-Grande-Ser-Humano.md
          - section: "A nova poesia brasileira é mais que uma promessa"
            contents:
              - Volume-4/16-A-Nova-Poesia-Brasileira-é-mais-que-uma-Promessa/00-Jovem-Cinica-Desesperada-Terna.md
              - Volume-4/16-A-Nova-Poesia-Brasileira-é-mais-que-uma-Promessa/01-Nossos-Poetas-de-Hoje-Ousando-Rir-Dos-Dogmas-Com-Versos-Doidos-e-Ternos.md
      - "---"
      - section: "5 Alguns artistas da Semana de Arte Moderna de 1922: entrevistas, depoimentos e ensaios"
        href: Volume-5/index.qmd
        contents:
          - section: "Semana de Arte Moderna de 1922"
            contents:
              - Volume-5/1-Semana-de-Arte-Moderna-de-1922/00-Foi-Nosso-Primeiro-Happening-Urbano.md
              - Volume-5/1-Semana-de-Arte-Moderna-de-1922/01-e-Foi-Assim-Que-Nasceu-o-Brasil-de-Hoje-Com-Drummond-e-o-Romance-Social.md
          - section: "Emílio Di Cavalcanti"
            contents:
              - Volume-5/2-Emílio-Di-Cavalcanti/00-O-Adeus-Do-Mestre-Para-a-Pintura-Brasileira-Ficam-As-Mulatas-o-Morro-o-Mar-e-a-Semana-de-Arte-Moderna.md
              - Volume-5/2-Emílio-Di-Cavalcanti/01-Di-Para-Quem-Viver-Era-Um-Circulo-Magico.md
          - section: "Tarsila do Amaral"
            contents:
              - Volume-5/3-Tarsila-Do-Amaral/00-Tarsila-Do-Amaral-a-Ultima-Entrevista.md
          - section: "Menotti del Picchia"
            contents:
              - Volume-5/4-Menotti-Del-Picchia/00-Menotti-Del-Picchia-Nada-Me-Orgulha-Mais-Do-Que-Ter-Sido-Poeta.md
          - section: "Oswald de Andrade"
            contents:
              - Volume-5/5-Oswald-de-Andrade/00-Oswald-de-Andrade-o-Incoerente.md
          - section: "Mário de Andrade"
            contents:
              - Volume-5/6-Mário-de-Andrade/00-Astuto-Ou-Generoso-Mas-Sempre-Amoral.md
              - Volume-5/6-Mário-de-Andrade/01-Mario-o-Campo-Aberto-e-Nevoento-Do-Debate.md
              - Volume-5/6-Mário-de-Andrade/02-Curso-Sobre-o-Movimento-Modernista-Mario-de-Andrade.md
      - "---"
      - section: "6 Redescobrindo Portugal: Perfis e depoimentos de alguns escritores portugueses"
        href: Volume-6/index.qmd
        contents:
          - section: "Brasil-Portugal - tentativas de aproximação"
            contents:
              - Volume-6/01-Brasil--Portugal-Tentativas-de-Aproximação/00-Na-Contramao.md
              - Volume-6/01-Brasil--Portugal-Tentativas-de-Aproximação/01-Poetas-Portugueses-Versos-e-Duas-Culturas-Reencontram-Seu-Ponto-de-Uniao.md
              - Volume-6/01-Brasil--Portugal-Tentativas-de-Aproximação/02-Um-Encontro-de-Portugal-e-Brasil-Sobre-a-Liberdade.md
          - section: "Fernão Mendes Pinto"
            contents:
              - Volume-6/02-Fernão-Mendes-Pinto/00-a-Fascinante-Aventura-Do-Marco-Polo-Portugues.md
          - section: "Eça de Queirós"
            contents:
              - Volume-6/03-Eça-de-Queiros/00-Tese-e-Antitese-de-Eca-de-Queiros.md
              - Volume-6/03-Eça-de-Queiros/01-Suave-Milagre-No-Fim-Da-Vida-Um-Eca-Religioso.md
              - Volume-6/03-Eça-de-Queiros/02-Depois-Dele-Portugal-Nao-Foi-Mais-o-Mesmo-Nem-o-Portugues.md
              - Volume-6/03-Eça-de-Queiros/03-Uma-Obra-Prima-Inacabada-Com-a-Marca-Da-Grandeza-Olimpica-de-Eca.md
              - Volume-6/03-Eça-de-Queiros/04-Eca-de-Queiros-Cem-Anos-de-Sua-Morte.md
          - section: "Antero de Quental"
            contents:
              - Volume-6/04-Antero-de-Quental/00-Antero-de-Quental-o-Ideal-Estetico-e-Politico.md
          - section: "Antônio Lobo Antunes"
            contents:
              - Volume-6/05-Antônio-Lobo-Antunes/00-a-Ousadia-Deste-Irreverente-Escritor-Portugues.md
          - section: "Antônio José Saraiva"
            contents:
              - Volume-6/06-Antônio-José-Saraiva/00-Entrevista-Com-Antonio-Jose-Saraiva.md
          - section: "Manuel Ferreira"
            contents:
              - Volume-6/07-Manuel-Ferreira/00-Manuel-Ferreira-a-Bondade-e-a-Opressao.md
          - section: "Antônio Alçada Baptista"
            contents:
              - Volume-6/08-Antônio-Alcada-Baptista/00-Um-Feminismo-Sutil-Sucesso-Em-Portugal.md
          - section: "Ferreira de Castro"
            contents:
              - Volume-6/09-Ferreira-de-Castro/00-As-Novas-Dimensoes-Do-Realismo-Literario-(A-Selva-de-Ferreira-de-Castro).md
          - section: "Teixeira de Pascoais"
            contents:
              - Volume-6/10-Teixeira-de-Pascoais/00-Um-Poeta-Mistico-Na-Era-Atomica.md
          - section: "Fernando Namora"
            contents:
              - Volume-6/11-Fernando-Namora/00-Fernando-Namora.md
          - section: "Fernando Pessoa"
            contents:
              - Volume-6/12-Fernando-Pessoa/00-Fernando-Pessoa-I.md
              - Volume-6/12-Fernando-Pessoa/01-Fernando-Pessoa-Ii-Fotobiografias.md
              - Volume-6/12-Fernando-Pessoa/02-Fernando-Pessoa-Iii-o-Poeta-Singular-e-Plural-de-Joao-Alves-Das-Neves-(Editora-Expressao).md
              - Volume-6/12-Fernando-Pessoa/03-Entrevista-Com-Joao-Gaspar-Simoes-o-Poeta-e-a-Humanidade.md
          - section: "Vergílio Ferreira"
            contents:
              - Volume-6/13-Vergílio-Ferreira/00-Entrevista-a-Vergilio-Ferreira.md
              - Volume-6/13-Vergílio-Ferreira/01-Destruindo-a-Palavra-Para-Reencontra-La-Mais-Bela-e-Pura.md
          - section: "Eugênio de Andrade"
            contents:
              - Volume-6/14-Eugênio-de-Andrade/00-o-Amor-Erotico-de-Eugenio-de-Andrade-Delicado-Audaz.md
          - section: "José Cardoso Pires"
            contents:
              - Volume-6/15-José-Cardoso-Pires/00-Eis-Um-Grande-Escritor.md
              - Volume-6/15-José-Cardoso-Pires/01-Uma-Entrevista-Com-o-Maior-Escritor-Portugues-Do-Momento.md
              - Volume-6/15-José-Cardoso-Pires/02-Cardoso-Pires-Para-Quando-o-Brasil-Descobrir-Portugal.md
              - Volume-6/15-José-Cardoso-Pires/03-a-Tardia-Descoberta-de-Um-Polemico-Escritor-Portugues.md
              - Volume-6/15-José-Cardoso-Pires/04-Cardoso-Pires-Reinventa-Portugal.md
              - Volume-6/15-José-Cardoso-Pires/05-Desafiando-Os-Rinocerontes-Do-Poder.md
          - section: "José Saramago"
            contents:
              - Volume-6/16-José-Saramago/00-Saramago.md
              - Volume-6/16-José-Saramago/01-Um-Deus-Sadico-Martiriza-Sua-Marionete-Jesus.md
          - section: "Três breves notícias sobre escritores ou livros portugueses"
            contents:
              - Volume-6/17-Três-Breves-Notícias-sobre-Escritores-ou-Livros-Portugueses/00-Casais-Monteiro.md
              - Volume-6/17-Três-Breves-Notícias-sobre-Escritores-ou-Livros-Portugueses/01-De-Maria-Isabel-Barreno-Maria-Teresa-Horta-e-Maria-Velho-Da-Costa.md
              - Volume-6/17-Três-Breves-Notícias-sobre-Escritores-ou-Livros-Portugueses/02-Os-Novos-Tempos-de-Portugal.md
      - "---"
      - section: "7 As três grandes damas da literatura europeia: Virginia Woolf, Marguerite Yourcenar e Doris Lessing"
        href: Volume-7/index.qmd
        contents:
          - section: "Virginia Woolf"
            contents:
              - Volume-7/01-Virginia-Woolf/00-Arte-Amor-Morte.md
              - Volume-7/01-Virginia-Woolf/01-Ela-Foi-Muito-Mal-Recebida-No-Brasil-Pelo-Tradutor.md
              - Volume-7/01-Virginia-Woolf/02-o-Retrato-de-Virginia-Woolf-a-Luta-de-Uma-Escritora-Angustiada-Com-o-Efemero.md
              - Volume-7/01-Virginia-Woolf/03-Virginia-Woolf-Pensamentos-Ainda-Brilhantes-40-Anos-Depois.md
              - Volume-7/01-Virginia-Woolf/04-Woolf-Ainda-Um-Enigma-(A-Outra-Metade-Do-Artigo-Sobre-Yourcenar-Sera-Transcrito-Na-Proxima-Secao-Consagrada-a-Escritora-Belga).md
              - Volume-7/01-Virginia-Woolf/05-Virginia-Woolf-Anotacoes-Vividas-de-Uma-Estilista-Perfeita.md
          - section: "Marguerite Yourcenar"
            contents:
              - Volume-7/02-Marguerite-Yourcenar/00-Yourcenar-Na-Academia-Um-Premio-Para-a-Mulher.md
              - Volume-7/02-Marguerite-Yourcenar/01-a-Agonia-Tragica-e-Solene-de-Adriano-Num-Livro-Deslumbrante.md
              - Volume-7/02-Marguerite-Yourcenar/02-Uma-Viagem-Ao-Reino-Da-Dor-Do-Amor-Do-Poder-Da-Morte.md
              - Volume-7/02-Marguerite-Yourcenar/03-Yourcenar-Sempre-Pioneira-(Segunda-Metade-Do-Artigo-Cuja-Primeira-Parte-Inserimos-Na-Secao-Acima-Consagrada-a-Virginia-Woolf).md
              - Volume-7/02-Marguerite-Yourcenar/04-e-Fica-o-Brilho-de-Marguerite-Yourcenar.md
          - section: "Doris Lessing"
            contents:
              - Volume-7/03-Doris-Lessing/00-Doris-Lessing-Brilhante-Apesar-Da-Ma-Traducao.md
              - Volume-7/03-Doris-Lessing/01-Tragica-Lucida-Renovadora-Doris-Lessing.md
              - Volume-7/03-Doris-Lessing/02-Multipla-Doris-Lessing.md
              - Volume-7/03-Doris-Lessing/03-o-Teorema-Espacial-de-Doris-Lessing-Longo-e-Belo.md
              - Volume-7/03-Doris-Lessing/04-Doris-Lessing-de-1952-Apenas-Uma-Lembranca-Arqueologica.md
              - Volume-7/03-Doris-Lessing/05-Doris-Lessing-Derrubando-Mitos.md
              - Volume-7/03-Doris-Lessing/06-Doris-Lessing-Grandiosa-Vital.md
              - Volume-7/03-Doris-Lessing/07-Doris-Lessing-Uma-Rapsodia-Esplendida-Prisma-Da-Condicao-Humana.md
              - Volume-7/03-Doris-Lessing/08-Doris-Lessing-a-Dama-de-Ferro-Da-Literatura-Inglesa.md
              - Volume-7/03-Doris-Lessing/09-Doris-Lessing-a-Solitaria-Grendeza-de-Uma-Estilista.md
              - Volume-7/03-Doris-Lessing/10-Doris-Lessing-Mais-Uma-Vez-Fascinante.md
              - Volume-7/03-Doris-Lessing/11-Doris-Lessing.md
              - Volume-7/03-Doris-Lessing/12-a-Visita-Da-Majestosa-Senhora.md
              - Volume-7/03-Doris-Lessing/13-Entrevista-a-Doris-Lessing-o-Triunfo-Da-Inteligencia-Sem-Dogmas.md
              - Volume-7/03-Doris-Lessing/14-Lessing-Na-Trilha-Do-Horror.md
      - "---"
      - section: "8 Perscrutando a alma humana: a literatura italiana do pós-guerra"
        href: Volume-8/index.qmd
        contents:
          - section: "Italo Svevo"
            contents:
              - Volume-8/01-Ítalo-Svevo/00-Um-Romance-de-Italo-Svevo.md
              - Volume-8/01-Ítalo-Svevo/01-Svevo-Incompreendido-Revolucionario-e-Sem-Sucessores-Na-Italia.md
          - section: "Giuseppe Ungaretti"
            contents:
              - Volume-8/02-Giuseppe-Ungaretti/00-Ungaretti-Memorias-de-Um-Poeta-Maior-Vidente-Como-Rimbaud.md
          - section: "Carlo Emilio Gadda"
            contents:
              - Volume-8/03-Carlo-Emilio-Gadda/00-Gadda-(1893-1973).md
              - Volume-8/03-Carlo-Emilio-Gadda/01-A-Amargura-Humana-Em-Linguagem-Culta.md
              - Volume-8/03-Carlo-Emilio-Gadda/02-O-Mestre-Gadda.md
          - section: "Eugenio Montale"
            contents:
              - Volume-8/04-Eugenio-Montale/00-o-Poeta-Do-Amor-Da-Solidao-Do-Mediterraneo.md
              - Volume-8/04-Eugenio-Montale/01-a-Borboleta-de-Dinard-Este-Livro-Nao-Foi-Apenas-Traduzido-Foi-Destruido.md
          - section: "Ignazio Silone"
            contents:
              - Volume-8/05-Ignazio-Silone/00-Entrevista-Com-Ignazio-Silone-Ideias-Literatura-e-Artes-Varias.md
          - section: "Carlo Levi"
            contents:
              - Volume-8/06-Carlo-Levi/00-Carlo-Levi-e-a-Outra-Italia.md
              - Volume-8/06-Carlo-Levi/01-o-Despertar-Da-Consciencia-(A-Respeito-de-Um-Livro-de-Carlo-Levi).md
          - section: "Alberto Moravia"
            contents:
              - Volume-8/07-Alberto-Moravia/00-Alberto-Moravia-e-Os-Estudantes.md
              - Volume-8/07-Alberto-Moravia/01-Alberto-Moravia-e-Elsa-Morante-Entrevista-a-Leo-Gilson-Ribeiro.md
              - Volume-8/07-Alberto-Moravia/02-o-Mundo-Exposto-de-Moravia.md
          - section: "Cesare Pavese"
            contents:
              - Volume-8/08-Cesare-Pavese/00-a-Literatura-e-o-Homem.md
              - Volume-8/08-Cesare-Pavese/01-Traducao-de-Lgr-Do-Artigo-de-Cesare-Pavese-Regresso-Ao-Homem.md
              - Volume-8/08-Cesare-Pavese/02-Traducao-de-Lgr-Do-Artigo-de-Cesare-Pavese-Ler.md
              - Volume-8/08-Cesare-Pavese/03-a-Literatura-Como-Oficio.md
              - Volume-8/08-Cesare-Pavese/04-de-Uma-Nova-Literatura.md
          - section: "Giorgio Bassani"
            contents:
              - Volume-8/09-Giorgio-Bassani/00-Giorgio-Bassani-e-o-Conto-Moderno-Italiano.md
          - section: "Primo Levi"
            contents:
              - Volume-8/10-Primo-Levi/00-Inferno-Em-Auschwitz-Resenha-Sobre-o-Livro-Isto-e-Um-Homem-de-Primo-Levi.md
          - section: "Leonardo Sciascia"
            contents:
              - Volume-8/11-Leonardo-Sciascia/00-Caca-As-Bruxas-o-Caso-de-Caterina-Medici-Uma-Mulher-Acusada-de-Feiticaria-No-Seculo-Xvii-Resenha-Do-Livro-a-Bruxa-e-o-Capitao-de-Leonardo-Sciascia.md
              - Volume-8/11-Leonardo-Sciascia/01-Sciascia-a-Palavra-Radical.md
              - Volume-8/11-Leonardo-Sciascia/02-Trecho-Do-Ensaio-La-Corda-Pazza-de-L-Sciascia-Na-Traducao-de-Leo-Gilson-Ribeiro.md
          - section: "Italo Calvino"
            contents:
              - Volume-8/12-Ítalo-Calvino/00-Italo-Calvino.md
          - section: "Carlo Castellaneta"
            contents:
              - Volume-8/13-Carlo-Castellaneta/00-Nem-Arauto-Nem-Bobo-Da-Corte-o-Escritor-Segundo-Caltellaneta.md
              - Volume-8/13-Carlo-Castellaneta/01-Traducao-Do-Conto-de-Carlo-Castellaneta-Uma-Mulher-Invisivel)-Por-Leo-Gilson-Ribeiro.md
          - section: "Umberto Eco"
            contents:
              - Volume-8/14-Umberto-Eco/00-Mais-Um-Pastel-de-Vento-(Resenha-Ao-Livro-de-U-Eco-o-Pendulo-de-Foucault).md
      - "---"
      - section: "9 Conferências, ensaios e alguns artigos especiais"
        href: Volume-9/index.qmd
        contents:
          - section: "Caminhos e encontros"
            contents:
              - Volume-9/01-Caminhos-e-Encontros/index.qmd
          - section: "Ensaio de Hugo von Hofmannsthal (tradução de Leo Gilson Ribeiro)"
            contents:
              - Volume-9/02-Ensaio-de-Hugo-Von-Hofmannsthal/index.qmd
          - section: "As interrelações da pintura, da música e da literatura no período barroco"
            contents:
              - Volume-9/03-As-Interrelacoes-Da-Pintura-Da-Musica-e-Da-Literatura-No-Periodo-Barroco/index.qmd
          - section: "O Barroco e a literatura"
            contents:
              - Volume-9/04-O-Barroco-e-a-Literatura/index.qmd
          - section: "Especificidade da literatura brasileira"
            contents:
              - Volume-9/05-Especificidade-da-Literatura-Brasileira/index.qmd
          - section: "Psicologia e literatura. As boas e as más relações."
            contents:
              - Volume-9/06-Psicologia-e-Literatura-As-Boas-e-As-Mas-Relacoes/index.qmd
          - section: "Três vezes Toynbee"
            contents:
              - Volume-9/07-Tres-Vezes-Toynbee/00-Toynbee-e-a-Sua-Historia.md
              - Volume-9/07-Tres-Vezes-Toynbee/01-Arnold-Toynbee-Uma-Opcao-Para-o-Fim-Do-Mundo.md
              - Volume-9/07-Tres-Vezes-Toynbee/02-Toynbee-e-Seu-Panorama-de-Esperancas-e-Pessimismo.md
          - section: "De Selene à Apollo"
            contents:
              - Volume-9/08-De-Selene-a-Apollo/index.qmd
          - section: "Os autores do grito radical - Ginsberg, Genet, Gadda e Borges"
            contents:
              - Volume-9/09-Os-Autores-Do-Grito-Radical-Ginsberg-Genet-Gadda-e-Borges/index.qmd
          - section: "Genet, um homem à margem"
            contents:
              - Volume-9/10-Genet-Um-Homem-a-Margem/index.qmd
          - section: "Um produto que a Alalc não negocia - cultura"
            contents:
              - Volume-9/11-Um-Produto-Que-a-Alalc-Nao-Negocia-Cultura/index.qmd
      - "---"
      - section: "10 Grandes contistas brasileiros do século XX"
        href: Volume-10/index.qmd
        contents:
          - Volume-10/00-Uma-nova-antologia.md
          - Volume-10/01-Uma-coletanea-de contos.md
          - Volume-10/02-Uma-boa-antologia-de-contos-brasileiros.md
          - Volume-10/03-Nota-sobre-Contos-tradicionais-do-Brasil.md
          - section: "João Antônio e seu submundo visceral"
            contents:
              - Volume-10/01-Joao-Antonio/00-Um-clássico-velhaco.md
              - Volume-10/01-Joao-Antonio/01-O-livro-que-deu-um-soco-em-nosso-crítico.md
              - Volume-10/01-Joao-Antonio/02-O-mendigo-o-moleque-e-o-malandro-de-João-Antônio.md
              - Volume-10/01-Joao-Antonio/03-João-Antônio-fascinado-pelas-palavras-É-um-perigo.md
          - section: "Dalton Trevisan e a sua tragicomédia conjugal"
            contents:
              - Volume-10/02-Dalton-Trevisan/00-Leia-esse-ótimo-livro-de-contos.md
              - Volume-10/02-Dalton-Trevisan/01-Resenha-do-livro-A-Guerra-Conjugal.md
              - Volume-10/02-Dalton-Trevisan/02-A-guerra-de-João-e-Maria.md
              - Volume-10/02-Dalton-Trevisan/03-O-triste-cemitério-de-Dalton-Trevisan.md
              - Volume-10/02-Dalton-Trevisan/04-A-metamorfose.md
              - Volume-10/02-Dalton-Trevisan/05-Dalton-Trevisan.md
              - Volume-10/02-Dalton-Trevisan/06-Dalton-Trevisan-traz-mais-histórias.md
              - Volume-10/02-Dalton-Trevisan/07-Abismo-de-Rosas.md
              - Volume-10/02-Dalton-Trevisan/08-Um-ensaio-para-a-conscientização-E-que-chega-à-grande-estreia.md
              - Volume-10/02-Dalton-Trevisan/09-A-perfeição-contundente-e-sublime-dos-contos-de-Trevisan.md
              - Volume-10/02-Dalton-Trevisan/10-O-Kama-Sutra-de-Trevisan-sem-céu-inferno-ou-purgatório.md
              - Volume-10/02-Dalton-Trevisan/11-A-tragicomédia-de-Trevisan-em-renovada-e-envolvente-concisão-telegráfica.md
              - Volume-10/02-Dalton-Trevisan/12-Em-busca-da-libido-perdida.md
              - Volume-10/02-Dalton-Trevisan/13-A-reafirmação-feminista-de-Dalton-Trevisan.md
              - Volume-10/02-Dalton-Trevisan/14-Dalton-Trevisan-No-20º-livro-um-texto-arejado-E-a-competência-de-sempre.md
              - Volume-10/02-Dalton-Trevisan/15-Dalton-Trevisan-Mais-uma-obra-prima-Trágica-hilariante-patética.md
              - Volume-10/02-Dalton-Trevisan/16-A-humanidade-alucinada-de-Dalton-Trevisan.md
              - Volume-10/02-Dalton-Trevisan/17-Resenha-ao-livro-Arara-Bêbada.md
          - section: "José J. Veiga e o seu mundo fantástico e absurdo"
            contents:
              - Volume-10/03-Jose-J-Veiga/00-Uma-viagem-ao-absurdo.md
              - Volume-10/03-Jose-J-Veiga/01-E-nós-seremos-uma-tribo-De-selvagens.md
              - Volume-10/03-Jose-J-Veiga/02-Uma-história-fantástica-contada-por-um-mestre.md
          - section: "Rubem Fonseca e a renovação do conto brasileiro"
            contents:
              - Volume-10/04-Rubem-Fonseca/00-Não-deixe-de-ler-Ele-inova-o-conto-brasileiro.md
              - Volume-10/04-Rubem-Fonseca/01-O-resto-é-lixo.md
              - Volume-10/04-Rubem-Fonseca/02-Um-Rubem-Fonseca-ofendido-e-humilhado.md
              - Volume-10/04-Rubem-Fonseca/03-Fonseca-em-nova-e-amarga-obra-prima.md
          - section: "Otto Lara Resende e o baú mágico de Minas Gerais"
            contents:
              - Volume-10/05-Otto-Lara-Resende/00-Otto-Lara-Resende-do-fundo-do-baú-mágico-da-memória-de-Minas-Gerais.md
              - Volume-10/05-Otto-Lara-Resende/01-Entrevista-com-Otto-Lara-Resende.md
          - section: "Ricardo Ramos"
            contents:
              - Volume-10/06-Ricardo-Ramos/00-O-talento-de-dois-senhores-contistas.md
          - section: "Luís Vilela e a hostilidade cotidiana nas metrópoles"
            contents:
              - Volume-10/07-Luis-Vilela/00-Ler-Vilela-Indispensável.md
              - Volume-10/07-Luis-Vilela/01-Este-não-é-um-romance-É-uma-vingança-pessoal-cheia-de-chavões.md
          - section: "João Gilberto Noll e a complexidade plural das relações humanas"
            contents:
              - Volume-10/08-Joao-Gilberto-Noll/00-João-Gilberto-Noll-um-clarão-de-lucidez-em-anos-de-treva.md
          - section: "Guilherme Scalzilli"
            contents:
              - Volume-10/09-Guilherme-Scalzilli/00-Um-gênio-anônimo.md
              - Volume-10/09-Guilherme-Scalzilli/01-Guilherme-Scalzilli.md
STR

new_list = []

str.split("\n").each do |line|
  if line.include?('- Volume-')
    prefix = line.split(/^\s+\S/)[0]
    new_list << prefix + string_to_path(line)
  else
    new_list << line
  end
end

puts new_list.join("\n")

#
# the_dir = '/Users/bcdav/Dropbox/Projetos/Blogs/LGR/Volume-10/**/*'
# Dir.glob(the_dir).each do |file|
#   next unless File.directory?(file)
#
#   base_path = "#{File.dirname(file)}/"
#   new_name = base_path + string_to_path(File.basename(file))
#   p new_name
#   # abort
#   # p string_to_path(file)
#   File.rename(file, new_name) #or upcase if you want to convert to uppercase
#   # abort
# end
