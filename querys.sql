
SELECT * FROM cliente;

-- Lista os serviços disponíveis na oficina.
SELECT idServico, descricao, valor_mao_de_obra FROM servico;

-- Lista todos os clientes que moram no estado de SP.
SELECT nome, sobrenome, cidade, estado 
FROM cliente 
WHERE estado = 'MG';

-- Lista os mecânicos especializados em suspensão.
SELECT nome, especializacao 
FROM mecanico 
WHERE especializacao = 'Suspensão';


-- Lista as ordens de serviço abertas.
SELECT * 
FROM ordem_de_servico 
WHERE status_OS <> 'Concluído';


-- Calcula o valor total de cada ordem de serviço considerando peças e serviços.
SELECT os.idOrdemServico, 
       SUM(op.valor_total_peca) AS total_pecas, 
       SUM(osv.valor_total_servico) AS total_servicos, 
       (SUM(op.valor_total_peca) + SUM(osv.valor_total_servico)) AS valor_total_os
FROM ordem_de_servico os
LEFT JOIN orcamento_peca op ON os.idOrdemServico = op.ordem_de_servico_idOrdemServico
LEFT JOIN orcamento_servico osv ON os.idOrdemServico = osv.ordem_de_servico_idOrdemServico
GROUP BY os.idOrdemServico;


-- Lista as ordens de serviço ordenadas pela data de emissão (mais recente primeiro).
SELECT idOrdemServico, data_emissao, status_OS 
FROM ordem_de_servico 
ORDER BY data_emissao DESC;


-- Lista os clientes ordenados por nome em ordem alfabética.
SELECT idCliente, nome, sobrenome 
FROM cliente 
ORDER BY nome ASC;



-- Lista os mecânicos que possuem mais de 1 ordem de serviço associadas.
SELECT m.idMecanico, m.nome, COUNT(os.idOrdemServico) AS total_os
FROM mecanico m
JOIN equipe e ON m.equipe_idEquipe = e.idEquipe
JOIN ordem_de_servico os ON e.idEquipe = os.equipe_idEquipe
GROUP BY m.idMecanico, m.nome
HAVING COUNT(os.idOrdemServico) > 1;


-- Lista todas as ordens de serviço com informações do cliente e veículo.
SELECT os.idOrdemServico, c.nome AS nome_cliente, v.modelo AS veiculo, os.data_emissao, os.status_OS
FROM ordem_de_servico os
JOIN veiculo v ON os.veiculo_idVeiculo = v.idVeiculo
JOIN cliente c ON v.Cliente_idcliente = c.idCliente;


-- Lista as peças utilizadas nas ordens de serviço, com seus valores e quantidades.
SELECT os.idOrdemServico, pv.nome AS nome_peca, op.quantidade, op.valor_total_peca
FROM ordem_de_servico os
JOIN orcamento_peca op ON os.idOrdemServico = op.ordem_de_servico_idOrdemServico
JOIN peca_veiculo pv ON op.peca_Veiculo_idPecaVeiculo = pv.idPecaVeiculo;


-- Verifica quais equipes realizaram serviços e os valores totais de cada uma.
SELECT e.idEquipe, e.nome_equipe, SUM(os.valor_total) AS total_servicos
FROM equipe e
JOIN ordem_de_servico os ON e.idEquipe = os.equipe_idEquipe
GROUP BY e.idEquipe, e.nome_equipe;
