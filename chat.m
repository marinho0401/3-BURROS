function chat()
clear; clc;

apiKey = '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';
instrucao = 'Responde em texto simples sem Markdown nem LaTeX. Escreve formulas de forma linear. Ex: x = (a+b)/2';
mdl = 'llama-3.3-70b-versatile';
url = 'https://api.groq.com/openai/v1/chat/completions';

while true
    p = input('>> ', 's');

    if isempty(p), continue; end
    if any(strcmpi(p, {'s','exit','quit','sair'})), clear; clc; break; end

    jb = sprintf('{"model":"%s","max_tokens":1024,"messages":[{"role":"system","content":"%s"},{"role":"user","content":"%s"}]}', mdl, instrucao, strrep(p, '"', '\"'));
    op = weboptions('MediaType','application/json','Timeout',120,'HeaderFields',{'Authorization',['Bearer ',apiKey]});

    try
        r = webwrite(url, jb, op);
        fprintf('\n%s\n\n', strtrim(r.choices(1).message.content));
    catch
    end
end
end