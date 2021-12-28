# Docker file for NLP work

> *not so tiny but a bit tiny*

Docker file for Natural Language Processing with:

- mecab for Japanese morphological analysis <https://taku910.github.io/mecab/> with mecab-python3 <https://pypi.org/project/mecab-python3/>
- GiNZA for Japanese NLP <https://megagonlabs.github.io/ginza/>
- Jupyter for experimental code work <https://jupyter.org/>

 ref: <https://testdriven.io/blog/docker-best-practices/>

For mecab, mecab-ipadic-utf8 libmecab-dev will be installed
For GiNZA, ja_ginza (authentic model) will be installed. In case you need to use "Transformer based model", ja_ginza_electra, you need to uninstall ja_ginza and install with pip,

``` bash
pip uninstall ja_ginza
pip install ja_ginza_electra
```

Below is the sample code for dependant structure analysis with GiNZA/spaCy

```python
import spacy
nlp = spacy.load('ja_ginza')
doc = nlp('銀座でランチをご一緒しましょう。')
for sent in doc.sents:
    for token in sent:
        print(
          token.i,
          token.orth_,
          token.lemma_,
          token.norm_,
          token.morph.get("Reading"),
          token.pos_,
          token.morph.get("Inflection"),
          token.tag_,
          token.dep_,
          token.head.i,
        )
    print('EOS')
```