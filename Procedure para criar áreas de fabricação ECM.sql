create or replace PROCEDURE pcreate_area_fab_ecm (textId varchar2, textValue varchar2) is

userId number;
groupText number;
languageNumber number;

BEGIN
  --Descobrir o código do usuário
  select cd_usuario into userId from usuario_psw where ds_usuario = 'williamgd';
  
  groupText := SEQ_CAT_AGRUPA_TEXTO_PSW.nextval;
  
  --Criar o agrupador de texto
  insert into cat_agrupa_texto_psw values(groupText, textValue, sysdate, userId, sysdate, userId);
  
  --Definindo a linguagem (Espanhol)
  languageNumber := 2;
  
  --Adicionar a variação da descrição em espanhol
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, languageNumber, textValue);
  
  --Adicionar a área de fabricação do ECM
  insert into ecm_area_fabricacao_psw values (SEQ_ECM_AREA_FABRICACAO_PSW.nextval, textId, 'S', groupText, sysdate, userId, sysdate, userId);
  
  --Gravar os dados
  commit;
  
EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;  
END;