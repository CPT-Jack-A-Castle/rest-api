<?php declare(strict_types=1);

namespace Reconmap;

use Laminas\Diactoros\ResponseFactory;
use League\Container\Container;
use League\Route\RouteGroup;
use League\Route\Router;
use Monolog\Logger;
use Reconmap\{Controllers\AuditLog\AuditLogRouter,
    Controllers\Clients\ClientsRouter,
    Controllers\Commands\CommandsRouter,
    Controllers\Notes\NotesRouter,
    Controllers\Organisations\OrganisationsRouter,
    Controllers\Projects\ProjectsRouter,
    Controllers\Reports\ReportsRouter,
    Controllers\System\SystemRouter,
    Controllers\Targets\TargetsRouter,
    Controllers\Tasks\TasksRouter,
    Controllers\Users\UsersLoginController,
    Controllers\Users\UsersRouter,
    Controllers\Vulnerabilities\VulnerabilitiesRouter,
    Services\ApplicationConfig
};
use Reconmap\Controllers\Attachments\AttachmentsRouter;

class ApiRouter extends Router
{
    private const ROUTER_CLASSES = [
        AttachmentsRouter::class,
        AuditLogRouter::class,
        CommandsRouter::class,
        ClientsRouter::class,
        NotesRouter::class,
        OrganisationsRouter::class,
        ProjectsRouter::class,
        ReportsRouter::class,
        SystemRouter::class,
        TargetsRouter::class,
        TasksRouter::class,
        UsersRouter::class,
        VulnerabilitiesRouter::class,
    ];

    private Logger $logger;

    private AuthMiddleware $authMiddleware;

    private CorsMiddleware $corsMiddleware;

    private Container $container;

    private ApplicationConfig $config;

    /**
     * @param Container $container
     * @param Logger $logger
     */
    private function setupStrategy(Container $container, Logger $logger)
    {
        $this->container = $container;
        $this->logger = $logger;
        $this->config = $this->container->get(ApplicationConfig::class);

        $responseFactory = new ResponseFactory;

        $strategy = new ApiStrategy($responseFactory);
        $strategy->setConfig($this->config);
        $strategy->setContainer($container);

        $this->setStrategy($strategy);

        $this->authMiddleware = $container->get(AuthMiddleware::class);
        $this->corsMiddleware = $container->get(CorsMiddleware::class);
    }

    public function mapRoutes(Container $container, Logger $logger): void
    {
        $this->setupStrategy($container, $logger);

        $this->map('POST', '/users/login', UsersLoginController::class)
            ->middleware($this->corsMiddleware);

        $this->group('', function (RouteGroup $router): void {
            foreach (self::ROUTER_CLASSES as $mappable) {
                (new $mappable)->mapRoutes($router);
            }
        })->middlewares([$this->corsMiddleware, $this->authMiddleware]);
    }
}
