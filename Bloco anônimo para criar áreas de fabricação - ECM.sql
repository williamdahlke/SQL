declare
textId varchar2(10);
textValuePT varchar2(800);
textValueES varchar2(800);
textValueEN varchar2(800);
userId number;
groupText number;

BEGIN

  textId := 'D_PA ';   
  textValuePT := 'Enrolamentos de distribuição/encapsulamento até montagem da parte ativa';
  textValueES := 'Distribución/Encapsulados Devanados hasta ensamble Parte Activa';
  textValueEN := 'Distribution/Encapsulations Windings until Active Part assembly';

  --Descobrir o código do usuário
  select cd_usuario into userId from usuario_psw where ds_usuario = 'williamgd';

  groupText := SEQ_CAT_AGRUPA_TEXTO_PSW.nextval;

  --Criar o agrupador de texto
  insert into cat_agrupa_texto_psw values(groupText, textValuePT, sysdate, userId, sysdate, userId);

  --Adicionar a variação da descrição em português
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 1, textValuePT);

  --Adicionar a variação da descrição em espanhol
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 2, textValueES);

  --Adicionar a variação da descrição em inglês
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 3, textValueEN);

  --Adicionar a área de fabricação do ECM
  insert into ecm_area_fabricacao_psw values (SEQ_ECM_AREA_FABRICACAO_PSW.nextval, textId, 'S', groupText, sysdate, userId, sysdate, userId);

  --Gravar os dados
  commit;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;  
END;