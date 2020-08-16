<?php

declare(strict_types=1);

namespace Reconmap\Controllers;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;

class IndexController extends Controller
{

	public function handleRequest(ServerRequestInterface $request): ResponseInterface
	{
		$response = new \GuzzleHttp\Psr7\Response;
		$response->getBody()->write('Reconmap API');
		return $response;
	}
}