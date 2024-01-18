declare
textId varchar2(10);
textValuePT varchar2(800);
textValueES varchar2(800);
textValueEN varchar2(800);
userId number;
groupText number;

BEGIN

  textId := 'D_PA ';   
  textValuePT := 'Enrolamentos de distribui��o/encapsulamento at� montagem da parte ativa';
  textValueES := 'Distribuci�n/Encapsulados Devanados hasta ensamble Parte Activa';
  textValueEN := 'Distribution/Encapsulations Windings until Active Part assembly';

  --Descobrir o c�digo do usu�rio
  select cd_usuario into userId from usuario_psw where ds_usuario = 'williamgd';

  groupText := SEQ_CAT_AGRUPA_TEXTO_PSW.nextval;

  --Criar o agrupador de texto
  insert into cat_agrupa_texto_psw values(groupText, textValuePT, sysdate, userId, sysdate, userId);

  --Adicionar a varia��o da descri��o em portugu�s
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 1, textValuePT);

  --Adicionar a varia��o da descri��o em espanhol
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 2, textValueES);

  --Adicionar a varia��o da descri��o em ingl�s
  insert into cat_texto_traducao_psw values (SEQ_CAT_TEXTO_TRADUCAO_PSW.nextval, groupText, 3, textValueEN);

  --Adicionar a �rea de fabrica��o do ECM
  insert into ecm_area_fabricacao_psw values (SEQ_ECM_AREA_FABRICACAO_PSW.nextval, textId, 'S', groupText, sysdate, userId, sysdate, userId);

  --Gravar os dados
  commit;

EXCEPTION
  WHEN OTHERS THEN
    ROLLBACK;
    RAISE;  
END;